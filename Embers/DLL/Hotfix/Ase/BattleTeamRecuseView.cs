using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleTeamRecuseView : UGuiView
{
	public CircleImage RoleImage;

	public Image RecuseFill;

	public Image RebornEnergyFill;

	public RectTransform RecuseArea;

	public Transform RecuseDir;

	public GameObject BeingRescuedEffect;

	public float RecuseUIMoveSpeed = 10f;

	private BattleUserViewModel viewModel;

	private float fillStart = 0.623f;

	private float fillEnd = 0.879f;

	private float RecuseUIDirMinDis;

	private Vector2 finalPos = Vector2.zero;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BattleUserViewModel>(userData);
		BindingSet<BattleTeamRecuseView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => !vm.IsEmpty && vm.HeroData.ShowRecuseIcon);
		if (RoleImage != null)
		{
			bindingSet.Bind(RoleImage).For((CircleImage v) => v.sprite).To((BattleUserViewModel vm) => vm.IconPath)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind(RecuseDir.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => !vm.HeroData.IsSelf);
		bindingSet.Bind(BeingRescuedEffect).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.HeroData.BeingRescued);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<BattleUserViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	private new void OnEnable()
	{
		GetFinalPos();
		base.transform.localPosition = finalPos;
	}

	private void LateUpdate()
	{
		if (viewModel != null)
		{
			ObservableDictionary<string, Ase.ECS.PropertyData> property = viewModel.HeroData.Property;
			if (RecuseFill != null && property.ContainsKey("RebornProgress") && property.ContainsKey("RebornNeedProgress"))
			{
				RecuseFill.fillAmount = Mathf.Clamp01(fillStart + (fillEnd - fillStart) * (1f - property["RebornProgress"].CurValue / property["RebornNeedProgress"].CurValue));
			}
			if (RebornEnergyFill != null && property.ContainsKey("RebornEneryRemaind") && property.ContainsKey("RebornEneryProgress"))
			{
				RebornEnergyFill.fillAmount = Mathf.Clamp01(property["RebornEneryRemaind"].CurValue / property["RebornEneryProgress"].CurValue);
			}
		}
		GetFinalPos();
		base.transform.localPosition = Vector3.Lerp(base.transform.localPosition, finalPos, RecuseUIMoveSpeed * Time.deltaTime);
	}

	private void GetFinalPos()
	{
		if (viewModel != null && viewModel.HeroData.IsSelf)
		{
			BaseEntity entity = viewModel.HeroData.Entity;
			if (entity != null)
			{
				Vector3 vector = entity.GetSystem<CameraSystem>().BattleCamera.WorldToScreenPoint(entity.GetComponent<EntityBoneComponent>().GetBonePosition("RescueUI"));
				Vector2 vector2 = default(Vector2);
				RectTransformUtility.ScreenPointToLocalPointInRectangle(RecuseArea, (Vector2)vector, UIUtilly.GetUICamera(), ref vector2);
				finalPos = vector2;
			}
			return;
		}
		BaseEntity entity2 = viewModel.HeroData.Entity;
		if (entity2 == null)
		{
			return;
		}
		if (RecuseUIDirMinDis == 0f)
		{
			RecuseUIDirMinDis = entity2.GetWorld().BattleConfig.RecuseUIDirMinDis;
		}
		int actorId = entity2.GetWorld().ActorId;
		BaseEntity entity3 = entity2.GetSystem<EntitySystem>().GetEntity(actorId);
		if (entity3 == null)
		{
			return;
		}
		Vector3 vector3 = entity2.GetSystem<CameraSystem>().BattleCamera.WorldToScreenPoint(entity2.transform.position);
		Vector3 bonePosition = entity2.GetComponent<EntityBoneComponent>().GetBonePosition("RescueUI");
		Vector3 vector4 = entity2.GetSystem<CameraSystem>().BattleCamera.WorldToScreenPoint(bonePosition);
		Vector2 vector5 = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(RecuseArea, (Vector2)vector3, UIUtilly.GetUICamera(), ref vector5);
		Vector2 vector6 = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(RecuseArea, (Vector2)vector4, UIUtilly.GetUICamera(), ref vector6);
		Vector3 vector7 = entity2.GetSystem<CameraSystem>().BattleCamera.WorldToScreenPoint(entity3.transform.position);
		Vector2 d = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(RecuseArea, (Vector2)vector7, UIUtilly.GetUICamera(), ref d);
		if (RecuseArea.rect.Contains(vector6))
		{
			RecuseDir.gameObject.SetActive(value: false);
			finalPos = vector6;
			return;
		}
		Vector2 intersection = Vector2.zero;
		if (GetIntersection(vector6, d, new Vector2(RecuseArea.rect.xMin, RecuseArea.rect.yMin), new Vector2(RecuseArea.rect.xMin, RecuseArea.rect.yMax), ref intersection) && intersection.x < 0f && vector6.x < 0f)
		{
			SetRecuseDir(Vector2.down, vector5 - intersection);
			finalPos = intersection;
		}
		else if (GetIntersection(vector6, d, new Vector2(RecuseArea.rect.xMax, RecuseArea.rect.yMin), new Vector2(RecuseArea.rect.xMax, RecuseArea.rect.yMax), ref intersection) && intersection.x > 0f && vector6.x > 0f)
		{
			SetRecuseDir(Vector2.down, vector5 - intersection);
			finalPos = intersection;
		}
		else if (GetIntersection(vector6, d, new Vector2(RecuseArea.rect.xMin, RecuseArea.rect.yMin), new Vector2(RecuseArea.rect.xMax, RecuseArea.rect.yMin), ref intersection) && intersection.y < 0f && vector6.y < 0f)
		{
			SetRecuseDir(Vector2.down, vector5 - intersection);
			finalPos = intersection;
		}
		else if (GetIntersection(vector6, d, new Vector2(RecuseArea.rect.xMin, RecuseArea.rect.yMax), new Vector2(RecuseArea.rect.xMax, RecuseArea.rect.yMax), ref intersection) && intersection.y > 0f && vector6.y > 0f)
		{
			SetRecuseDir(Vector2.down, vector5 - intersection);
			finalPos = intersection;
		}
	}

	private void SetRecuseDir(Vector2 from, Vector2 to)
	{
		bool flag = to.sqrMagnitude > RecuseUIDirMinDis * RecuseUIDirMinDis;
		RecuseDir.gameObject.SetActive(flag);
		if (flag)
		{
			float num = Vector2.Angle(from, to);
			if (from.x * to.y - from.y * to.x < 0f)
			{
				num = 360f - num;
			}
			RecuseDir.localEulerAngles = Vector3.forward * num;
		}
	}

	public bool GetIntersection(Vector2 c, Vector2 d, Vector2 a, Vector2 b, ref Vector2 intersection)
	{
		Vector2 a2 = b - a;
		Vector2 b2 = c - a;
		float num = Cross(a2, b2);
		Vector2 b3 = d - a;
		float num2 = Cross(a2, b3);
		if (num * num2 >= 0f)
		{
			return false;
		}
		Vector2 a3 = d - c;
		Vector2 b4 = a - c;
		Vector2 b5 = b - c;
		float num3 = Cross(a3, b4);
		float num4 = Cross(a3, b5);
		if (num3 * num4 >= 0f)
		{
			return false;
		}
		float num5 = Cross(a - c, d - c) / Cross(d - c, b - a);
		float num6 = num5 * (b.x - a.x);
		float num7 = num5 * (b.y - a.y);
		intersection = new Vector2
		{
			x = a.x + num6,
			y = a.y + num7
		};
		return true;
	}

	public float Cross(Vector2 a, Vector2 b)
	{
		return a.x * b.y - b.x * a.y;
	}
}
