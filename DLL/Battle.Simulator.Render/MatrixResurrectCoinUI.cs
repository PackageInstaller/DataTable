using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MatrixResurrectCoinUI : MonoBehaviour
{
	public List<GameObject> gameObjects = new List<GameObject>();

	public List<GameObject> bgGameObjects = new List<GameObject>();

	public GameObject textToShow;

	public Text textleft;

	public float showTime;

	private int playerID;

	private string max;

	private bool show;

	private float current;

	private void Awake()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return;
		}
		for (int i = 0; i < gameObjects.Count; i++)
		{
			if (i < battleScene.resurrectCoinNumber)
			{
				gameObjects[i].SetActive(value: true);
			}
			else
			{
				gameObjects[i].SetActive(value: false);
			}
		}
		for (int j = 0; j < bgGameObjects.Count; j++)
		{
			if (j < battleScene.maxResurrectCoinNumber)
			{
				bgGameObjects[j].SetActive(value: true);
			}
			else
			{
				bgGameObjects[j].SetActive(value: false);
			}
		}
		max = "/" + battleScene.maxResurrectCoinNumber;
		playerID = battleScene.GetAgentManager().mPlayerAgentID;
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<SimResurrectEvent>(OnResurrectEvent);
	}

	private void OnResurrectEvent(SimResurrectEvent eventReceived)
	{
		if (eventReceived.state != ResurrectEventState.resurrect || eventReceived.entityID != playerID)
		{
			return;
		}
		int num = (int)eventReceived.coinNumber;
		for (int i = 0; i < gameObjects.Count; i++)
		{
			if (i < num)
			{
				gameObjects[i].SetActive(value: true);
			}
			else
			{
				gameObjects[i].SetActive(value: false);
			}
		}
		show = true;
		textToShow.SetActive(value: true);
		textleft.text = num + max;
	}

	private void Update()
	{
		if (!show)
		{
			textToShow.SetActive(value: false);
			current = 0f;
			return;
		}
		current += Time.deltaTime;
		if (current > showTime)
		{
			show = false;
		}
	}
}
