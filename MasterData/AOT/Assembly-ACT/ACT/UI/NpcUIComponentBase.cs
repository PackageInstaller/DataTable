using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class NpcUIComponentBase : MonoBehaviour
{
	public BImage icon;

	public virtual void Init()
	{
	}

	public virtual void UnInit()
	{
	}

	public virtual void ShowRefresh(bool enter)
	{
	}
}
