using System.Collections.Generic;
using RogueCard;
using UnityEngine;
using UnityEngine.UI;

public class RogueCardDeckInfoUI : MonoBehaviour
{
	public GameObject spade;

	public GameObject heart;

	public GameObject club;

	public GameObject diamond;

	private List<Text> spadeTextList;

	private List<Text> heartTextList;

	private List<Text> clubTextList;

	private List<Text> diamondTextList;

	public List<Text> numberTextList = new List<Text>();

	public Text spadeText;

	public Text heartText;

	public Text clubText;

	public Text diamondText;

	public void Init()
	{
		spadeTextList = new List<Text>();
		spadeTextList.AddRange(spade.GetComponentsInChildren<Text>());
		spadeTextList.Reverse();
		heartTextList = new List<Text>();
		heartTextList.AddRange(heart.GetComponentsInChildren<Text>());
		heartTextList.Reverse();
		clubTextList = new List<Text>();
		clubTextList.AddRange(club.GetComponentsInChildren<Text>());
		clubTextList.Reverse();
		diamondTextList = new List<Text>();
		diamondTextList.AddRange(diamond.GetComponentsInChildren<Text>());
		diamondTextList.Reverse();
	}

	public void RefreshUI()
	{
		Dictionary<(int, int), int> dictionary = new Dictionary<(int, int), int>();
		Dictionary<int, int> dictionary2 = new Dictionary<int, int>();
		List<int> list = new List<int> { 0, 0, 0, 0 };
		for (int i = 2; i <= 11; i++)
		{
			dictionary2[i] = 0;
			for (int j = 0; j <= 3; j++)
			{
				dictionary[(j, i)] = 0;
			}
		}
		foreach (RogueCardData card in RogueCardGameMain.GameContext.rogueDeck.cards)
		{
			dictionary[((int)(card.suit - 1), (int)card.rank)]++;
			dictionary2[(int)card.rank]++;
			list[(int)(card.suit - 1)]++;
		}
		for (int k = 2; k <= 11; k++)
		{
			spadeTextList[k - 2].text = dictionary[(0, k)].ToString();
			heartTextList[k - 2].text = dictionary[(1, k)].ToString();
			clubTextList[k - 2].text = dictionary[(2, k)].ToString();
			diamondTextList[k - 2].text = dictionary[(3, k)].ToString();
			numberTextList[k - 2].text = dictionary2[k].ToString();
		}
		spadeText.text = list[0].ToString();
		heartText.text = list[1].ToString();
		clubText.text = list[2].ToString();
		diamondText.text = list[3].ToString();
	}
}
