using DG.Tweening;
using GameFramework.Runtime;

namespace Ase;

public class BattleExpUpViewModel : OptionBase
{
	private int curLevel;

	private int targetLevel;

	private long curExp;

	private long targetExp;

	private long curMaxExp;

	private long targetMaxExp;

	private float expRate;

	private string curExpText;

	private string curLevelRankIcon = "";

	public float ExpTweenTime;

	public float Wait2TweenTime;

	private float wait2TweenTime;

	private Tweener expBarTween;

	private int expBarTweenId = 1;

	private InteractionRequest<bool> setExpBarVisible = new InteractionRequest<bool>();

	private InteractionRequest<bool> setLevelUpVisible = new InteractionRequest<bool>();

	private IMessenger messenger;

	private ISubscription<RoleExpOrLevelUpNotifyMessager> subscription;

	private bool waitTweening;

	private bool isTweening;

	public int CurLevel
	{
		get
		{
			return curLevel;
		}
		set
		{
			Set(ref curLevel, value, "CurLevel");
			CurMaxExp = GetMaxExp(curLevel);
			DRAccountGrade dataRow = GameEntry.DataTable.GetDataRow<DRAccountGrade>(value);
			if (dataRow != null)
			{
				CurLevelRankIcon = $"AccountRank_{dataRow.Rank}";
			}
		}
	}

	public int TargetLevel
	{
		get
		{
			return targetLevel;
		}
		set
		{
			Set(ref targetLevel, value, "TargetLevel");
			TargetMaxExp = GetMaxExp(targetLevel);
		}
	}

	public long CurExp
	{
		get
		{
			return curExp;
		}
		set
		{
			Set(ref curExp, value, "CurExp");
			ExpRate = (float)CurExp / (float)CurMaxExp;
			CurExpText = $"{CurExp}/{CurMaxExp}";
		}
	}

	public long TargetExp
	{
		get
		{
			return targetExp;
		}
		set
		{
			Set(ref targetExp, value, "TargetExp");
		}
	}

	public long CurMaxExp
	{
		get
		{
			return curMaxExp;
		}
		set
		{
			Set(ref curMaxExp, value, "CurMaxExp");
			ExpRate = (float)CurExp / (float)CurMaxExp;
			CurExpText = $"{CurExp}/{CurMaxExp}";
		}
	}

	public long TargetMaxExp
	{
		get
		{
			return targetMaxExp;
		}
		set
		{
			Set(ref targetMaxExp, value, "TargetMaxExp");
		}
	}

	public float ExpRate
	{
		get
		{
			return expRate;
		}
		set
		{
			Set(ref expRate, value, "ExpRate");
		}
	}

	public string CurExpText
	{
		get
		{
			return curExpText;
		}
		set
		{
			Set(ref curExpText, value, "CurExpText");
		}
	}

	public string CurLevelRankIcon
	{
		get
		{
			return curLevelRankIcon;
		}
		set
		{
			Set(ref curLevelRankIcon, value, "CurLevelRankIcon");
		}
	}

	public InteractionRequest<bool> SetExpBarVisible => setExpBarVisible;

	public InteractionRequest<bool> SetLevelUpVisible => setLevelUpVisible;

	public BattleExpUpViewModel()
	{
	}

	public BattleExpUpViewModel(OptionBase parent)
	{
		base.parent = parent;
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription = messenger.Subscribe<RoleExpOrLevelUpNotifyMessager>(OnExpOrLevelChangeNotify);
		PlayerData playerData = (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData())?.PlayerInfo;
		if (playerData != null)
		{
			CurLevel = playerData.Level;
			TargetLevel = playerData.Level;
			CurExp = playerData.Exp;
			TargetExp = playerData.Exp;
			CurMaxExp = GetMaxExp(playerData.Level);
			TargetMaxExp = GetMaxExp(playerData.Level);
		}
	}

	public void OnUpdate(float deltaTime)
	{
		if (isTweening)
		{
			return;
		}
		if (WaitTweenCheck())
		{
			if (wait2TweenTime < Wait2TweenTime)
			{
				wait2TweenTime += deltaTime;
				return;
			}
			wait2TweenTime = 0f;
			StartExpBarTween();
		}
		else
		{
			wait2TweenTime = 0f;
		}
	}

	private void OnExpOrLevelChangeNotify(RoleExpOrLevelUpNotifyMessager messager)
	{
		SetExpAndLevel(messager.Level, messager.Exp);
	}

	private void SetExpAndLevel(int newLevel, long newExp)
	{
		TargetLevel = newLevel;
		TargetExp = newExp;
		if (expBarTween.IsActive())
		{
			ExpBarTween();
		}
	}

	private bool WaitTweenCheck()
	{
		bool num = CurLevel != TargetLevel;
		bool flag = num || CurExp != TargetExp;
		return num | flag;
	}

	private void StartExpBarTween()
	{
		isTweening = true;
		SetExpBarVisible.Raise(context: true);
	}

	public void ExpBarTween()
	{
		long num = ((CurLevel != TargetLevel) ? CurMaxExp : TargetExp);
		if (expBarTween == null)
		{
			expBarTween = DOTween.To(() => CurExp, delegate(long x)
			{
				CurExp = x;
			}, num, ExpTweenTime).OnComplete(delegate
			{
				SetExpBarVisible.Raise(context: false);
			}).SetEase(Ease.Linear)
				.OnKill(delegate
				{
					expBarTween = null;
				})
				.SetAutoKill()
				.SetId(expBarTweenId);
		}
		else
		{
			expBarTween.ChangeEndValue(num, ExpTweenTime, snapStartValue: true);
		}
	}

	public void OnExpBarTweenCompleted()
	{
		if (CurLevel != TargetLevel)
		{
			CurExp = 0L;
			CurLevel = TargetLevel;
			SetLevelUpVisible.Raise(context: true);
		}
		else
		{
			isTweening = false;
		}
	}

	public void OnLevelUpTweenCompleted()
	{
		StartExpBarTween();
	}

	private long GetMaxExp(int level)
	{
		DRAccountGrade dataRow = GameEntry.DataTable.GetDataRow<DRAccountGrade>(level + 1);
		if (dataRow != null)
		{
			return dataRow.NeedExp;
		}
		return 0L;
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		if (subscription != null)
		{
			subscription.Dispose();
			subscription = null;
		}
	}
}
