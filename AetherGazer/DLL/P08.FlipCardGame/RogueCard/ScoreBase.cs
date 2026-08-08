namespace RogueCard;

public abstract class ScoreBase
{
	private float _score;

	private float _multi;

	public float allMulti = 100f;

	public bool isMulti;

	public bool isLevelUp;

	public int isEnhance;

	public int addDraw;

	public int addDiscard;

	public bool suppressFlyText;

	public bool playTogetherWithNext;

	public float score
	{
		get
		{
			return _score;
		}
		set
		{
			if (!(_score >= 2.1474836E+09f))
			{
				_score = ((value >= 2.1474836E+09f) ? 2.1474836E+09f : value);
			}
		}
	}

	public float multi
	{
		get
		{
			return _multi;
		}
		set
		{
			if (!(_multi >= 2.1474836E+09f))
			{
				_multi = ((value >= 2.1474836E+09f) ? 2.1474836E+09f : value);
			}
		}
	}

	public ScoreBase()
	{
		Reset();
	}

	public virtual void Reset()
	{
		score = 0f;
		multi = 0f;
		allMulti = 100f;
		isMulti = false;
		isLevelUp = false;
		isEnhance = 0;
		suppressFlyText = false;
		playTogetherWithNext = false;
	}

	public abstract int GetIndex();
}
