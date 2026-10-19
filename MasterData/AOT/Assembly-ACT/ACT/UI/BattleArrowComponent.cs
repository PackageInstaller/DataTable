using System.Collections.Generic;
using ACT.Battle;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class BattleArrowComponent : MonoBehaviour, IBattleMainComponent
{
	private MonoBattleMainBaseView _view;

	public CanvasGroup battleArrow;

	public List<BattleArrowGroup> battleArrowGroups;

	private List<BattleArrowGroup> _tempBattleArrowGroups = new List<BattleArrowGroup>();

	private List<BattleArrowGroup> _tempNpcArrowGroups = new List<BattleArrowGroup>();

	private List<Entity> _tempArrowEntities = new List<Entity>();

	public RectTransform battleInvisibleArea;

	public float foldAngle = 10f;

	public void Initialize(MonoBattleMainBaseView view)
	{
		_view = view;
	}

	public void UnInitialize()
	{
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void LateUpdate()
	{
		if ((bool)_view)
		{
			RefreshEnemyArrows();
		}
	}

	private void RefreshEnemyArrows()
	{
		if (MonoECS.instance.playState != PlayState.Battle)
		{
			battleArrow.alpha = 0f;
		}
		else
		{
			if (battleArrowGroups == null)
			{
				return;
			}
			battleArrow.alpha = 1f;
			_tempBattleArrowGroups.Clear();
			_tempNpcArrowGroups.Clear();
			_tempArrowEntities.Clear();
			WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
			if (worldManager == null || worldManager.GetCurrentWorld()?.SceneStatus != SceneStatus.Rogue)
			{
				_tempArrowEntities.AddRange(GameManager.hatredSystem.hatredList);
			}
			_tempArrowEntities.AddRange(GameManager.apcSystem.Apcs);
			int num = 0;
			foreach (Entity tempArrowEntity in _tempArrowEntities)
			{
				if (num >= battleArrowGroups.Count)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError("battle arrow 数量，超出范围");
					}
					break;
				}
				BattleArrowGroup battleArrowGroup = battleArrowGroups[num];
				battleArrowGroup.canvasGroup.alpha = 0f;
				if (!tempArrowEntity.IsActive())
				{
					continue;
				}
				CompTransform compTransform = tempArrowEntity.GetCompTransform();
				Vector3 vector = GameUtility.mainCamera.WorldToScreenPoint(compTransform.colliderPosition);
				vector.y += compTransform.size.y / 2f;
				Vector2 screenCenter = UIUtility.screenCenter;
				screenCenter.y -= UIUtility.fullScreen.y / 4f + GameLoader.meta.refreshEnemyArrowsHeightOffset;
				if (!RectTransformUtility.RectangleContainsScreenPoint(battleInvisibleArea, vector, GameUtility.uiCamera))
				{
					battleArrowGroup.canvasGroup.alpha = 1f;
					Vector2 vector2 = UIUtility.OvalConstraint((Vector2)vector - screenCenter, _view.semiMajorAxis, _view.semiMinorAxis) + screenCenter;
					vector.x = vector2.x;
					vector.y = vector2.y;
					vector.z = battleArrow.transform.position.z;
					Vector3 position = GameUtility.uiCamera.ScreenToWorldPoint(vector);
					battleArrowGroup.transform.position = position;
					battleArrowGroup.transform.rotation = Quaternion.FromToRotation(Vector2.up, (Vector2)vector - screenCenter);
					if (tempArrowEntity.IsAssistNpc())
					{
						battleArrowGroup.SetType(BattleArrowGroup.ArrowType.Apc);
						_tempNpcArrowGroups.Add(battleArrowGroup);
					}
					else
					{
						battleArrowGroup.SetType(BattleArrowGroup.ArrowType.Monster);
						_tempBattleArrowGroups.Add(battleArrowGroup);
					}
				}
				num++;
			}
			if (num < battleArrowGroups.Count)
			{
				for (int i = num; i < battleArrowGroups.Count; i++)
				{
					battleArrowGroups[i].canvasGroup.alpha = 0f;
				}
			}
			SortAndGroupArrow(_tempBattleArrowGroups);
			SortAndGroupArrow(_tempNpcArrowGroups);
		}
	}

	private void SortAndGroupArrow(List<BattleArrowGroup> groups)
	{
		groups.Sort((BattleArrowGroup p1, BattleArrowGroup p2) => p1.AngleFromOrigin().CompareTo(p2.AngleFromOrigin()));
		int num = 1;
		int num2 = groups.Count - 1;
		while (num2 > 0 && 360f - groups[num2].angle + groups[0].angle < foldAngle)
		{
			groups[num2].canvasGroup.alpha = 0f;
			groups.RemoveAt(num2);
			num++;
			num2--;
		}
		for (int num3 = 0; num3 < groups.Count; num3++)
		{
			int num4 = 1;
			int num5 = num3 + 1;
			groups[num3].multiGroup.alpha = 0f;
			groups[num3].oneGroup.alpha = 1f;
			groups[num3].ArrowAngleReset();
			if (num3 == 0)
			{
				num4 = num;
				if (num4 > 1)
				{
					groups[num3].multiGroup.alpha = 1f;
					groups[num3].oneGroup.alpha = 0f;
					groups[num3].foldNum.SetText("{0:0}", num4);
				}
			}
			if (num5 >= groups.Count)
			{
				continue;
			}
			for (int num6 = num5; num6 < groups.Count; num6++)
			{
				num5 = num6;
				if (!(groups[num6].angle - groups[num3].angle < foldAngle))
				{
					break;
				}
				groups[num6].canvasGroup.alpha = 0f;
				num4++;
			}
			if (num4 > 1)
			{
				_tempBattleArrowGroups[num3].multiGroup.alpha = 1f;
				_tempBattleArrowGroups[num3].oneGroup.alpha = 0f;
				_tempBattleArrowGroups[num3].foldNum.SetText("{0:0}", num4);
			}
			num3 = num5 - 1;
		}
	}
}
