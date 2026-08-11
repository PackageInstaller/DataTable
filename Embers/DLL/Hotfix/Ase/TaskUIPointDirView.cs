using System;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TaskUIPointDirView : UGuiView
{
	[SerializeField]
	private Transform RecuseDir;

	[SerializeField]
	private float RecuseUIMoveSpeed = 10f;

	[SerializeField]
	private RectTransform RecuseArea;

	[SerializeField]
	private TextMeshProUGUI distanceShowText;

	[SerializeField]
	private RectTransform distanceTextParent;

	[SerializeField]
	private Image Icon;

	private float dirRotateAngle;

	private Vector2 finalPos = Vector2.zero;

	private BattleTaskUIPosViewModel _viewModel;

	private bool initFinish;

	private int updateTextTimeFrame;

	public bool InitFinish => initFinish;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = userData as BattleTaskUIPosViewModel;
		BindingSet<TaskUIPointDirView, BattleTaskUIPosViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		if (Icon != null)
		{
			bindingSet.Bind(Icon).For((Image v) => v.sprite).ToExpression((BattleTaskUIPosViewModel vm) => vm.IconName)
				.WithConversion("ItemIcon");
		}
		bindingSet.Build();
		initFinish = true;
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		_viewModel = userData as BattleTaskUIPosViewModel;
		this.SetDataContext(_viewModel);
	}

	private new void OnEnable()
	{
		updateTextTimeFrame = 0;
	}

	private void LateUpdate()
	{
		if (_viewModel == null)
		{
			if (CanvasGroup.alpha != 0f)
			{
				CanvasGroup.alpha = 0f;
			}
			return;
		}
		if (updateTextTimeFrame <= 0)
		{
			GetFinalPos();
			JudeActorDisUIPoint();
			updateTextTimeFrame = 3;
		}
		else
		{
			updateTextTimeFrame--;
		}
		base.transform.localPosition = Vector3.Lerp(base.transform.localPosition, finalPos, RecuseUIMoveSpeed * Time.deltaTime);
	}

	private void GetFinalPos()
	{
		Vector3 vector = GameEntry.Camera.MainCamera.WorldToScreenPoint(_viewModel.ActorPos);
		Vector2 vector2 = default(Vector2);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(RecuseArea, (Vector2)vector, UIUtilly.GetUICamera(), ref vector2);
		Vector3 vector3 = GameEntry.Camera.MainCamera.WorldToScreenPoint(_viewModel.UIPos);
		Vector2 vector4 = Vector2.zero;
		if (vector3.z >= 0f)
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(RecuseArea, (Vector2)vector3, UIUtilly.GetUICamera(), ref vector4);
		}
		else
		{
			Quaternion quaternion = Quaternion.Euler(0f, 0f - GameEntry.Camera.MainCamera.transform.localEulerAngles.y, 0f);
			Vector3 vector5 = quaternion * _viewModel.ActorPos;
			Vector2 vector6 = (quaternion * _viewModel.UIPos).ToVector2() - vector5.ToVector2();
			vector4 = vector2 + vector6.normalized * 100000f;
		}
		if (RecuseArea.rect.Contains(vector4))
		{
			if (CanvasGroup.alpha != 0f)
			{
				CanvasGroup.alpha = 0f;
			}
			return;
		}
		if (CanvasGroup.alpha != 1f)
		{
			CanvasGroup.alpha = 1f;
		}
		Vector2 intersection = Vector2.zero;
		if (GetIntersection(vector4, vector2, new Vector2(RecuseArea.rect.xMin, RecuseArea.rect.yMin), new Vector2(RecuseArea.rect.xMin, RecuseArea.rect.yMax), ref intersection) && intersection.x < 0f && vector4.x < 0f)
		{
			SetRecuseDir(Vector2.down, vector4 - intersection);
			finalPos = intersection;
		}
		else if (GetIntersection(vector4, vector2, new Vector2(RecuseArea.rect.xMax, RecuseArea.rect.yMin), new Vector2(RecuseArea.rect.xMax, RecuseArea.rect.yMax), ref intersection) && intersection.x > 0f && vector4.x > 0f)
		{
			SetRecuseDir(Vector2.down, vector4 - intersection);
			finalPos = intersection;
		}
		else if (GetIntersection(vector4, vector2, new Vector2(RecuseArea.rect.xMin, RecuseArea.rect.yMin), new Vector2(RecuseArea.rect.xMax, RecuseArea.rect.yMin), ref intersection) && intersection.y < 0f && vector4.y < 0f)
		{
			SetRecuseDir(Vector2.down, vector4 - intersection);
			finalPos = intersection;
		}
		else if (GetIntersection(vector4, vector2, new Vector2(RecuseArea.rect.xMin, RecuseArea.rect.yMax), new Vector2(RecuseArea.rect.xMax, RecuseArea.rect.yMax), ref intersection) && intersection.y > 0f && vector4.y > 0f)
		{
			SetRecuseDir(Vector2.down, vector4 - intersection);
			finalPos = intersection;
		}
	}

	private void SetRecuseDir(Vector2 from, Vector2 to)
	{
		float num = Vector2.Angle(from, to);
		if (from.x * to.y - from.y * to.x < 0f)
		{
			num = 360f - num;
		}
		dirRotateAngle = num;
		RecuseDir.localEulerAngles = Vector3.forward * num;
	}

	public Vector2 GetPointOnEllipse(float angle, float xR, float yR, Vector2 center)
	{
		float f = angle * (MathF.PI / 180f);
		float x = center.x + xR * Mathf.Cos(f);
		float y = center.y + yR * Mathf.Sin(f);
		return new Vector2(x, y);
	}

	private void JudeActorDisUIPoint()
	{
		float num = Vector3.Distance(_viewModel.UIPos, _viewModel.ActorPos);
		((TMP_Text)distanceShowText).text = (int)num + "m";
		((TMP_Text)distanceShowText).ForceMeshUpdate(false, false);
		float angle = dirRotateAngle + 90f;
		float xR = 25f + ((TMP_Text)distanceShowText).preferredHeight / 2f + ((TMP_Text)distanceShowText).preferredWidth / 2f;
		float yR = 25f + ((TMP_Text)distanceShowText).preferredHeight / 2f;
		distanceTextParent.anchoredPosition = GetPointOnEllipse(angle, xR, yR, Vector2.zero);
		if (num <= _viewModel.UIPointRadius && _viewModel.UIPointRadius != 0f)
		{
			CanvasGroup.alpha = 0f;
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
