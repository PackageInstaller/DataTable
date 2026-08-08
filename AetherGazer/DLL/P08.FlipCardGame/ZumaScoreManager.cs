using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaScoreManager : MonoBehaviour
{
	public ZumaPool<ZumaScoreItem> scorePool;

	public GameObject scoreObj;

	public Transform scoreNode;

	private List<ZumaScoreItem> useScoreList = new List<ZumaScoreItem>();

	public List<numSpirte> scoreSpriteList;

	public Dictionary<int, Sprite> scoreSpriteDict = new Dictionary<int, Sprite>();

	private void Awake()
	{
		for (int i = 0; i < scoreSpriteList.Count; i++)
		{
			scoreSpriteDict.Add(scoreSpriteList[i].numIndex, scoreSpriteList[i].sprite);
		}
		scorePool = new ZumaPool<ZumaScoreItem>(InstanceScoreItemFunc, 5);
		ZumaGameManager.GetInstance().SetZumaScoreManager(this);
	}

	private ZumaScoreItem InstanceScoreItemFunc()
	{
		ZumaScoreItem component = Object.Instantiate(scoreObj, scoreNode).GetComponent<ZumaScoreItem>();
		component.Init(this);
		return component;
	}

	public void ShowScore(Vector3 pos, int numValue, bool isGold, bool isEnter)
	{
		ZumaScoreItem ballObj = scorePool.GetBallObj();
		ballObj.transform.position = pos;
		ballObj.ShowNum(numValue, isGold, isEnter);
	}

	public Sprite GetNumValueSprite(int numIndex)
	{
		return scoreSpriteDict[numIndex];
	}
}
