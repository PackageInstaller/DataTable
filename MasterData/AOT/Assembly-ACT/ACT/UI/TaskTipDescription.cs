using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.MissionSystem;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TaskTipDescription : MonoBehaviour
{
	public static Color OrangeColor1;

	public static Color OrangeColor2;

	public GameObject descriptionDetail;

	public GameObject descriptionRoot;

	public LocalizeStringEvent description;

	public TextMeshProUGUI descriptionText;

	public TextMeshProUGUI progress;

	[Header("图标")]
	public BImage missionTypeImage;

	public GameObject completedImage;

	public GameObject defaultIcon;

	public GameObject completeEffect;

	[Header("位置相关")]
	public GameObject distanceRoot;

	public TextMeshProUGUI distance;

	public GameObject inZoneRoot;

	public GameObject gotoMapButtonRoot;

	public TextMeshProUGUI gotoMapText;

	public ActButton gotoMapButton;

	[Header("超链接功能")]
	public GameObject hyperLinkRoot;

	public LocalizeStringEvent hyperLinkLocalizeString;

	public TextMeshProUGUI hyperLinkText;

	public ActButton hyperLinkButton;

	public BetterAnimation betterAnimation;

	private TaskTip_Tracing m_TaskTipTracing;

	private int m_MissionId;

	private int m_ConditionId;

	private bool m_HaveContent;

	private bool m_HaveMissionPoint;

	private int m_MissionPointId;

	private bool m_IsSameArea;

	private int m_Distance;

	private bool m_InZone;

	private bool m_HaveHyperLink;

	private IConditionDescriptionHyperLink m_HyperLinkLogic;

	public int MissionId => m_MissionId;

	public int ConditionId => m_ConditionId;

	static TaskTipDescription()
	{
		ColorUtility.TryParseHtmlString("#EFE073", out OrangeColor1);
		ColorUtility.TryParseHtmlString("#FFFD58", out OrangeColor2);
	}

	private void Awake()
	{
		gotoMapButton.SetBtnClick(OnGotoMapClick);
		hyperLinkButton.SetBtnClick(OnHyperLinkClick);
	}

	public void Init(TaskTip_Tracing taskTipTracing)
	{
		m_TaskTipTracing = taskTipTracing;
	}

	private void OnGotoMapClick()
	{
		if (!m_IsSameArea)
		{
			m_TaskTipTracing.Manager.View.GetController()?.OnOpenMissionTarget(force: false);
		}
	}

	private void OnHyperLinkClick()
	{
		if (m_HaveHyperLink)
		{
			m_HyperLinkLogic?.OnClick();
		}
	}

	public async UniTask PlayComplete()
	{
		if ((bool)betterAnimation)
		{
			AnimationBuilder sequence = betterAnimation.GetSequence("Complete");
			if (sequence != null)
			{
				CancellationToken cancellationTokenOnDestroy = gameObject.GetCancellationTokenOnDestroy();
				await sequence.Play().AwaitComplete().AttachExternalCancellation(cancellationTokenOnDestroy);
			}
		}
	}

	public void SetUp(ConditionDescription conditionDescription, ImageAssetStation imageStation, bool isInit = true)
	{
		m_HaveContent = conditionDescription.HaveContent;
		m_MissionId = conditionDescription.MissionId;
		m_ConditionId = conditionDescription.ConditionId;
		descriptionDetail.SetActive(m_HaveContent);
		completeEffect?.SetActive(value: false);
		defaultIcon.SetActive(conditionDescription.IconType == MissionType.Error);
		missionTypeImage.icon.gameObject.SetActive(!conditionDescription.IsFinished && conditionDescription.IconType != MissionType.Error);
		if (conditionDescription.IconType != MissionType.Error)
		{
			imageStation?.LoadImage(200, (int)conditionDescription.IconType, missionTypeImage);
		}
		completedImage.gameObject.SetActive(conditionDescription.IsFinished);
		if (conditionDescription.DescriptionContent != null)
		{
			description.StringReference = conditionDescription.DescriptionContent;
		}
		else
		{
			description.StringReference = new LocalizedString(conditionDescription.DescriptionContentTable, conditionDescription.DescriptionContentId);
		}
		progress.gameObject.SetActive(conditionDescription.HaveContent && conditionDescription.HaveProgress);
		progress.SetText("({0:0}/{1:0})", conditionDescription.Progress, conditionDescription.TotalProgress);
		hyperLinkRoot.SetActive(conditionDescription.HaveHyperLink);
		if (conditionDescription.HyperLinkText != null)
		{
			hyperLinkLocalizeString.StringReference = conditionDescription.HyperLinkText;
		}
		else
		{
			hyperLinkLocalizeString.StringReference.TableReference = conditionDescription.HyperLinkTextTable;
			hyperLinkLocalizeString.StringReference.TableEntryReference = conditionDescription.HyperLinkTextId;
		}
		m_HaveHyperLink = conditionDescription.HaveHyperLink;
		m_HyperLinkLogic = conditionDescription.HyperLinkLogic;
		m_HaveMissionPoint = conditionDescription.HaveMissionPoint;
		m_MissionPointId = conditionDescription.MissionPointId;
		UpdateDistance();
	}

	public void SetContentMultiLine(bool multiLine)
	{
		if (multiLine)
		{
			descriptionText.enableWordWrapping = true;
			descriptionText.overflowMode = TextOverflowModes.Overflow;
		}
		else
		{
			descriptionText.enableWordWrapping = false;
			descriptionText.overflowMode = TextOverflowModes.Ellipsis;
		}
	}

	public async UniTask UpdateState(ConditionDescription description, ImageAssetStation imageStation)
	{
		if (description.MissionId == m_MissionId && description.ConditionId == m_ConditionId)
		{
			SetUp(description, imageStation);
			await PlayComplete().SuppressCancellationThrow();
		}
	}

	private void UpdateDistance()
	{
		if (!MonoECS.instance.isStartWorld)
		{
			inZoneRoot.SetActive(value: false);
			distanceRoot.SetActive(value: false);
			gotoMapButtonRoot.SetActive(value: false);
			return;
		}
		MissionPointData missionPointData = null;
		if (m_HaveMissionPoint)
		{
			missionPointData = Model<BattleMainMarkModelV2>.Interface.PointDict.GetValueOrDefault(m_MissionPointId);
		}
		if (missionPointData == null)
		{
			m_Distance = 0;
			m_InZone = false;
			distanceRoot.SetActive(value: false);
			inZoneRoot.SetActive(value: false);
			gotoMapButtonRoot.SetActive(value: false);
			return;
		}
		m_Distance = 0;
		m_InZone = false;
		m_IsSameArea = missionPointData.IsSameArea;
		if (missionPointData.IsSameArea)
		{
			Vector3? vector = MonoECS.instance.mainEntity.GetCompTransform()?.physicsPosition;
			if (vector.HasValue)
			{
				m_Distance = (int)Math.Ceiling(Vector3.Distance(missionPointData.GetActualPos(), vector.Value));
				m_InZone = (float)m_Distance <= missionPointData.Radius;
			}
			else
			{
				m_Distance = 0;
				m_InZone = false;
			}
		}
		else
		{
			m_Distance = 0;
			m_InZone = false;
		}
		Color color = OrangeColor1;
		string empty = string.Empty;
		string empty2 = string.Empty;
		if (!m_IsSameArea)
		{
			color = OrangeColor1;
			MapArea data = CoreUtils.GetData((int)missionPointData.MapArea, RuntimeConfigs.data.mapAreas);
			if (data != null)
			{
				int localizeId = data.name;
				empty2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, localizeId);
				empty = string.Empty;
			}
			else
			{
				empty2 = string.Empty;
				empty = string.Empty;
			}
		}
		else
		{
			empty2 = string.Empty;
			if (!m_InZone)
			{
				color = OrangeColor2;
				empty = m_Distance.FastToString() + "m";
			}
			else
			{
				empty = string.Empty;
			}
		}
		distance.text = empty;
		distance.color = color;
		if (m_IsSameArea)
		{
			gotoMapText.gameObject.SetActive(value: false);
			if (m_InZone)
			{
				distanceRoot.SetActive(value: false);
				inZoneRoot.SetActive(value: true);
			}
			else
			{
				distanceRoot.SetActive(value: true);
				inZoneRoot.SetActive(value: false);
			}
		}
		else
		{
			inZoneRoot.SetActive(value: false);
			distanceRoot.SetActive(value: false);
			gotoMapText.gameObject.SetActive(value: true);
			gotoMapText.text = empty2;
		}
	}

	private void Update()
	{
		UpdateDistance();
	}
}
