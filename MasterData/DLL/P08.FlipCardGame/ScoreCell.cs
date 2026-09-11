using P08.Quiz;
using UnityEngine;
using UnityEngine.UI;

public class ScoreCell : GridCell
{
	[SerializeField]
	private int score;

	public Text scoreText;

	public Text enemyScoreText;

	public GameObject selfScoreObj;

	public GameObject enemyScoreObj;

	public BloodCardEnum.PlayerRole role;

	public GameObject selfEffectGo;

	public GameObject enemyEffectGo;

	public GameObject fireGo;

	public GameObject enemyFireGo;

	public GameObject loopFireGo;

	public GameObject loopEnemyFireGo;

	public int Score
	{
		get
		{
			return score;
		}
		protected set
		{
			score = value;
		}
	}

	public void SetScore(int value, bool needAni = true)
	{
		int num = Score;
		if (role == BloodCardEnum.PlayerRole.SELF)
		{
			if (needAni && value > num)
			{
				StartCoroutine(MonoSingleton<BloodCardManager>.Instance.AnimateScore(scoreText, num, value, selfEffectGo));
			}
			else
			{
				scoreText.text = value.ToString();
			}
		}
		else if (needAni && value > num)
		{
			StartCoroutine(MonoSingleton<BloodCardManager>.Instance.AnimateScore(enemyScoreText, num, value, enemyEffectGo));
		}
		else
		{
			enemyScoreText.text = value.ToString();
		}
		Score = value;
	}

	public override void Initialize()
	{
		base.Initialize();
		Score = 0;
		fireGo.SetActive(value: false);
		enemyFireGo.SetActive(value: false);
		loopFireGo.SetActive(value: false);
		loopEnemyFireGo.SetActive(value: false);
	}
}
