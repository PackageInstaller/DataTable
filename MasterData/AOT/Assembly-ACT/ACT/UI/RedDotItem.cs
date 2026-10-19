using System.Collections.Generic;
using System.Linq;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class RedDotItem : LuminSerializedMonoBehaviour
{
	public RedDotType redDotType;

	public GameObject dot;

	public GameObject numDot;

	public TextMeshProUGUI numberText;

	public GameObject newDot;

	public GameObject systemNewDot;

	public List<string> fullPath;

	[HideInInspector]
	public RedDotTrieNode redDotTrieNode;

	[SerializeReference]
	public RedDotDisplayAction displayAction;

	private bool forbidDotShow;

	public bool ForbidDotShow
	{
		get
		{
			return forbidDotShow;
		}
		set
		{
			forbidDotShow = value;
		}
	}

	public void UpdateDisplay()
	{
		bool isactive = false;
		if (displayAction == null || ForbidDotShow)
		{
			isactive = false;
		}
		else if (redDotTrieNode != null)
		{
			isactive = displayAction.Do(redDotTrieNode);
		}
		UpdateRedDot(isactive);
	}

	private void UpdateRedDot(bool isactive)
	{
		dot.SetActive(redDotType == RedDotType.Dot);
		if (newDot != null && numDot != null && systemNewDot != null)
		{
			newDot.SetActive(redDotType == RedDotType.New);
			numDot.SetActive(redDotType == RedDotType.Number);
			systemNewDot.SetActive(redDotType == RedDotType.SystemNew);
			if (redDotType == RedDotType.Number && isactive)
			{
				numberText.SetText("{0:0}", redDotTrieNode.ActiveChildCount);
			}
		}
		gameObject.SetActive(isactive);
	}

	public void BindTrieNode()
	{
		if (fullPath != null && fullPath.Count != 0)
		{
			Singleton<RedDotManager>.instance.GetNode(fullPath)?.BindRedDotItem(this);
		}
	}

	private void SetRedDotShowType()
	{
		dot.SetActive(redDotType == RedDotType.Dot);
		newDot.SetActive(redDotType == RedDotType.Dot);
		numDot.SetActive(redDotType == RedDotType.Dot);
	}

	public void InitRedDot(string FullPath, RedDotType redDotType = RedDotType.Dot)
	{
		this.redDotType = redDotType;
		if (!string.IsNullOrEmpty(FullPath))
		{
			fullPath = FullPath.Split("|").ToList();
			BindTrieNode();
			UpdateDisplay();
		}
	}

	public void SetMultiplePath()
	{
	}
}
