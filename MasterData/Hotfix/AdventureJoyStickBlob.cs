using System.Collections.Generic;
using DG.Tweening;
using TrueSync;
using UnityEngine;
using UnityEngine.UI;

public class AdventureJoyStickBlob : MonoBehaviour
{
	public float blobScale = 1.5f;

	public float blobOffset = 0.05f;

	public List<Image> dodge;

	public bool isShow;

	public List<Image> dodgeAlpha;

	private Color ColorOut = new Color(1f, 1f, 1f, 0f);

	private Color Colorint = new Color(1f, 1f, 1f, 1f);

	private void Start()
	{
		if (MonoSingleton<GameController>.Instance.entryLevelUIFadeIn)
		{
			for (int i = 0; i < dodgeAlpha.Count; i++)
			{
				dodgeAlpha.get_Item(i).color = ColorOut;
			}
		}
	}

	public void Show()
	{
		isShow = true;
		gameObject.SetActive(value: true);
	}

	public void Hide()
	{
		isShow = false;
		gameObject.SetActive(value: false);
	}

	public void OnRefresh()
	{
		if (!isShow)
		{
			gameObject.SetActive(value: false);
			return;
		}
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor == null)
		{
			return;
		}
		ActorHealthInfo actorHealthInfo = ((activedPlayerActor == null) ? null : activedPlayerActor.actorHealthInfo);
		if (!(activedPlayerActor != null) || !actorHealthInfo.isAlive)
		{
			return;
		}
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(activedPlayerActor.dataID);
		if (logicEntity != null)
		{
			PlayerSkillCd logicComponent = logicEntity.GetLogicComponent<PlayerSkillCd>();
			if (logicComponent != null)
			{
				int currentBindSkillId = logicComponent.GetCurrentBindSkillId(ActionKey.A);
				SkillInfo skillCD = logicComponent.GetSkillCD(currentBindSkillId);
				if (skillCD != null)
				{
					if (skillCD.totalSectionAmount > 0)
					{
						for (int i = 0; i < 3; i++)
						{
							dodge.get_Item(i).enabled = i < skillCD.currentSectionAmount;
						}
					}
					else
					{
						dodge.get_Item(0).enabled = skillCD.currentUseInterval <= 0;
						dodge.get_Item(1).enabled = false;
						dodge.get_Item(2).enabled = false;
					}
				}
				else
				{
					for (int j = 0; j < 3; j++)
					{
						dodge.get_Item(j).enabled = false;
					}
				}
			}
			else
			{
				for (int k = 0; k < 3; k++)
				{
					dodge.get_Item(k).enabled = false;
				}
			}
		}
		Transform transform = activedPlayerActor.transform;
		Vector3 position = new Vector3(transform.position.x, transform.position.y + blobOffset, transform.position.z);
		float num = (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput() ? FP.ToFloat(SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputAngle()) : transform.rotation.eulerAngles.y);
		float num2 = (float)activedPlayerActor.dtCollider.Radius * 0.02f * blobScale;
		new Vector2(num2, num2);
		base.transform.position = position;
		base.transform.localScale = new Vector3(num2, num2, num2);
		base.transform.rotation = Quaternion.Euler(new Vector3(90f, 0f, 0f - num));
	}

	public void FadeInJoy()
	{
		for (int i = 0; i < dodgeAlpha.Count; i++)
		{
			dodgeAlpha.get_Item(i).DOColor(Colorint, 0.7f);
		}
	}
}
