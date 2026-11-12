using System;
using System.Collections.Generic;
using System.Text;
using AK.Wwise;
using TrueSync;
using UnityEngine;
using UnityEngine.Serialization;

[Serializable]
public class Combo
{
	[Flags]
	public enum Phase
	{
		None = 0,
		Anticipation = 1,
		Activation = 2,
		Recovery = 4,
		All = Anticipation | Activation | Recovery
	}

	public enum ComboMode
	{
		Normal,
		Endless
	}

	public enum ComboClipMode
	{
		Once,
		Loop
	}

	[Serializable]
	public class CompositeComboClip
	{
		public ComboClip comboClip;

		public string eventGroupTag = "0:默认";
	}

	[Serializable]
	public class Event
	{
		public enum EventType
		{
			[InspectorName("自定义事件")]
			Custom = 0,
			[InspectorName("攻击")]
			Hit = 1,
			[InspectorName("射击")]
			Shoot = 2,
			[InspectorName("添加Buff")]
			AddBuff = 3,
			[InspectorName("区域效果")]
			AreaEffect = 5,
			[InspectorName("添加护盾")]
			AddShield = 7,
			[InspectorName("播放音效或语音")]
			PlayWwiseEvent = 9,
			[InspectorName("冻结时间（仅限抽卡角色）")]
			FrozenTime = 10,
			[InspectorName("特效")]
			Effect = 90,
			[InspectorName("关闭特效")]
			StopEffect = -90,
			[InspectorName("触发角色玩法逻辑公共事件")]
			TriggerCharGamePlayLogicCommonEvent = 20
		}

		public enum ClipPreconditionType
		{
			Any,
			Only,
			Except
		}

		public enum HitBoxConfigureWithGameData
		{
			Disable = 0,
			VisionData = 10,
			VisionDataWithDistanceOnly = 11,
			VisionDataWithAngleOnly = 12,
			HearData = 20,
			BodyDataWithSize = 31
		}

		public enum PlayerSkinEventOverrideType
		{
			[InspectorName("无")]
			None,
			[InspectorName("新增")]
			Add,
			[InspectorName("替换")]
			Replace,
			[InspectorName("删除")]
			Remove
		}

		public enum audioPlayType
		{
			[InspectorName("播放音效")]
			eventPlay,
			[InspectorName("播放语音")]
			voicePlay
		}

		public enum audioEvetType
		{
			[InspectorName("音效资源")]
			eventSource,
			[InspectorName("音效事件")]
			eventName
		}

		[HideInInspector]
		public bool fixedEventType;

		[HideInInspector]
		public bool isSimpleMode;

		public EventType type;

		public string uniqueID = "";

		public PlayerSkinEventOverrideType playerSkinEventOverrideType;

		public string tag = "";

		public bool IsShowInHitBoxEditor = true;

		public string name;

		[ComboClipFrameMinMaxSlider]
		public TSVector2 activeNormalizedTimeRange;

		public bool playOnceInLoopMode;

		public ClipPreconditionType clipPreconditionType;

		public ComboClip preconditionClip;

		public HitBox.Shape hitBoxShape;

		public FP hitBoxWidth = 1f;

		public FP hitBoxLength = 1f;

		public FP hitBoxRadius = 1f;

		public FP hitBoxInnerRadius;

		public FP hitBoxAngle;

		public HitBoxConfigureWithGameData hitBoxConfigureWithGameData;

		public FP hitBoxRotation;

		public TSVector2 hitBoxOffset;

		public FP hitBoxOffsetY;

		public bool offsetFollowActor;

		public bool lockHitBoxTransformOnEnd = true;

		public FP hitBoxRotationOnEnd;

		public TSVector2 hitBoxOffsetOnEnd;

		public bool enableHitBoxCurveMotion;

		public TSVector2 hitBoxCurveMotionControlPoint1;

		public TSVector2 hitBoxCurveMotionControlPoint2;

		public bool areaWithActorScale = true;

		public int hitDamageId;

		public HitBox.FeatureFlag hitFlags;

		public HitBox.HitBoxFeatureData hitFeatureData;

		public HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small;

		public GameObject hittedEffectPrefab;

		public bool isHittedEffectScale = true;

		public bool effectIgnoreTimeScale = true;

		public FP damageImmuneDuration = -1;

		public FP damageDetectInterval;

		public bool haveFeedbackEffect;

		public bool blockBullet;

		public TargetType blockBulletTargetType = TargetType.Enemy;

		public GameObject blockFinishFx;

		public GameObject bulletPrefab;

		public int ControlIndex;

		[Min(0f)]
		public int bulletCount;

		[Min(0f)]
		public int reduceAmmoCount;

		public AdventureWeapon.MultipleShootStyle multipleShootStyle;

		public bool useShootDeviationCalcScatteringRadius;

		public FP shootScatteringRadius = 0f;

		public FP multipleShootBulletDirectionOffset = 0f;

		public bool alignShoot;

		public FP alignShootDelay = 0f;

		public FP innerRadius = 0f;

		public FP range = 5f;

		public AimType aimType;

		public BulletDirectionType bulletDirectionType = BulletDirectionType.ActorToBullet;

		[FormerlySerializedAs("oneShotEffectPrefab")]
		public GameObject effectPrefab;

		public bool isEarlyWarningEffect;

		public float effectScale = 1f;

		public bool actorScale;

		public float effectPlaySpeed = 1f;

		public FP effectDuration = 1f;

		public bool interruptCancelEffect;

		public bool cancelEffectWhenLoopStop;

		public AdventurePlayerFeedbackEffectConfigureData playerfeedbackEffectConfigureData;

		public bool interruptCancelPlayerFeedbackEffect;

		public List<int> buffIds;

		public GameObject AreaEffectPrefab;

		public bool lockTarget = true;

		public bool useOwnerDirection;

		public FP rotationAngleOffset = 0;

		public float distance;

		public float offset;

		public int shiledID;

		public bool toTeam;

		public audioPlayType _audioPlayType;

		public string mainVoice;

		public string asseitVoice;

		public audioEvetType _audioEvetType;

		public AK.Wwise.Event _wwiseEvent;

		public string wwiseEventName;

		public bool _includeSelf;

		[Space]
		public bool triggerFateCardTheme;

		public bool normalAttackTriggerForFateCard;

		public bool dodgeTriggerForFateCard;

		public bool skillTriggerForFateCard;

		public bool ultimateTriggerForFateCard;

		public FP activeNormaliedDuration => activeNormalizedTimeRange.y - activeNormalizedTimeRange.x;

		public bool isInstantEvent => activeNormalizedTimeRange.x == activeNormalizedTimeRange.y;

		public Event()
		{
		}

		public Event(EventType eventType, bool isSimpleMode)
		{
			type = eventType;
			fixedEventType = true;
			this.isSimpleMode = isSimpleMode;
		}

		public FP GetAreaScale(AdventureActor actor)
		{
			if (actor == null)
			{
				return 1;
			}
			if (!areaWithActorScale)
			{
				return 1;
			}
			return actor.actorScaleInfo.modelScale;
		}
	}

	[Serializable]
	public class EventSkin
	{
		[HideInInspector]
		public int skinId;

		public bool preview;

		public Event[] comboEvents;
	}

	[Serializable]
	public class EventGroup
	{
		[HideInInspector]
		public int index;

		public string tag = "自定义";

		public EventSkin[] ComboEventSkins;
	}

	[Serializable]
	public class FeaturePhase
	{
		public string label = "[自定义]";

		[HideInInspector]
		public bool autoGenerateForAnticipation;

		[HideInInspector]
		public bool autoGenerateForActivation;

		[HideInInspector]
		public bool autoGenerateForRecovery;

		[ComboClipFrameSlider]
		public FP activeNormalizedTime;

		public AdventureSkillPhaseConfig skillPhaseConfig;

		public bool autoGenerate
		{
			get
			{
				if (!autoGenerateForAnticipation && !autoGenerateForActivation)
				{
					return autoGenerateForRecovery;
				}
				return true;
			}
		}
	}

	public ComboClipMode comboClipMode;

	public const int MinActionKeyNumber = 1;

	public const int MaxActionKeyNumber = 10;

	public bool autoLoad = true;

	public bool useActionKeys = true;

	public ComboInputBuffer.ActionKey[] requestKeys;

	public string actionTag;

	public CompositeComboClip[] compositeComboClips;

	public ComboSkillType comboSkillType;

	[HideInInspector]
	public bool useExitTime;

	private static StringBuilder _sb;

	public static readonly Dictionary<ComboInputBuffer.ActionKey, string> ActionKeyInspectorNames = new Dictionary<ComboInputBuffer.ActionKey, string>
	{
		{
			ComboInputBuffer.ActionKey.Nil,
			"--"
		},
		{
			ComboInputBuffer.ActionKey.A,
			"A"
		},
		{
			ComboInputBuffer.ActionKey.B,
			"B"
		},
		{
			ComboInputBuffer.ActionKey.C,
			"C"
		},
		{
			ComboInputBuffer.ActionKey.D,
			"D"
		},
		{
			ComboInputBuffer.ActionKey.E,
			"E"
		},
		{
			ComboInputBuffer.ActionKey.F,
			"F"
		},
		{
			ComboInputBuffer.ActionKey.G,
			"G"
		},
		{
			ComboInputBuffer.ActionKey.H,
			"H"
		},
		{
			ComboInputBuffer.ActionKey.I,
			"I"
		},
		{
			ComboInputBuffer.ActionKey.J,
			"J"
		},
		{
			ComboInputBuffer.ActionKey.K,
			"K"
		},
		{
			ComboInputBuffer.ActionKey.L,
			"L"
		},
		{
			ComboInputBuffer.ActionKey.M,
			"M"
		},
		{
			ComboInputBuffer.ActionKey.N,
			"N"
		},
		{
			ComboInputBuffer.ActionKey.O,
			"O"
		},
		{
			ComboInputBuffer.ActionKey.P,
			"P"
		},
		{
			ComboInputBuffer.ActionKey.Q,
			"Q"
		},
		{
			ComboInputBuffer.ActionKey.R,
			"R"
		},
		{
			ComboInputBuffer.ActionKey.S,
			"S"
		},
		{
			ComboInputBuffer.ActionKey.T,
			"T"
		},
		{
			ComboInputBuffer.ActionKey.U,
			"U"
		},
		{
			ComboInputBuffer.ActionKey.V,
			"V"
		},
		{
			ComboInputBuffer.ActionKey.W,
			"W"
		},
		{
			ComboInputBuffer.ActionKey.X,
			"X"
		},
		{
			ComboInputBuffer.ActionKey.Y,
			"Y"
		},
		{
			ComboInputBuffer.ActionKey.Z,
			"Z"
		},
		{
			ComboInputBuffer.ActionKey._0,
			"0"
		},
		{
			ComboInputBuffer.ActionKey._1,
			"1"
		},
		{
			ComboInputBuffer.ActionKey._2,
			"2"
		},
		{
			ComboInputBuffer.ActionKey._3,
			"3"
		},
		{
			ComboInputBuffer.ActionKey._4,
			"4"
		},
		{
			ComboInputBuffer.ActionKey._5,
			"5"
		},
		{
			ComboInputBuffer.ActionKey._6,
			"6"
		},
		{
			ComboInputBuffer.ActionKey._7,
			"7"
		},
		{
			ComboInputBuffer.ActionKey._8,
			"8"
		},
		{
			ComboInputBuffer.ActionKey._9,
			"9"
		}
	};

	public string requestKeysText
	{
		get
		{
			if (requestKeys == null || requestKeys.Length == 0)
			{
				return string.Empty;
			}
			if (_sb == null)
			{
				_sb = new StringBuilder();
			}
			else
			{
				_sb.Clear();
			}
			for (int i = 0; i < requestKeys.Length; i++)
			{
				_sb.Append(ActionKeyInspectorNames.get_Item(requestKeys[i]));
			}
			return _sb.ToString();
		}
	}
}
