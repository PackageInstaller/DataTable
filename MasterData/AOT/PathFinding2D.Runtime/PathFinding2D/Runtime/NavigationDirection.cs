using System.Collections.Generic;
using PathFinding2D.Models;
using PathFinding2D.Runtime.Models;
using UnityEngine;

namespace PathFinding2D.Runtime;

public class NavigationDirection : MonoBehaviour
{
	public const string HandEditRootName = "WayPoints (HandEdit)";

	[Tooltip("自动采样时沿哪个水平方向扫平台。一般用 (1,0,0) 表示从左到右。Y 分量会被忽略。")]
	public Vector3 scanDirection = Vector3.right;

	[Tooltip("参与自动采样的 Unity 物理层。只有这些层上的碰撞体会被当成可走平台。")]
	public LayerMask walkableLayers = -1;

	[SerializeField]
	[HideInInspector]
	public List<GameObject> debugObjects = new List<GameObject>();

	[SerializeField]
	[Tooltip("烘焙后的运行时图数据资源。场景加载时会用这份数据构建寻路图。")]
	private NavigationData navigationData;

	[SerializeField]
	[HideInInspector]
	private List<NavigationAuthoringLine> authoringLines = new List<NavigationAuthoringLine>();

	[SerializeField]
	[HideInInspector]
	private GameObject handEditRoot;

	[Tooltip("自动采样时的调试可视化（射线、净空盒颜色等）。正式导出前可关闭。")]
	public NavigationAutoTickerDebugSettings debugSettings;

	public NavigationData NavigationData => navigationData;

	public IReadOnlyList<NavigationAuthoringLine> AuthoringLines => authoringLines;

	public GameObject HandEditRoot => handEditRoot;

	public bool IsHandEditing => handEditRoot != null;

	public int AuthoringLineCount
	{
		get
		{
			if (authoringLines == null)
			{
				return 0;
			}
			return authoringLines.Count;
		}
	}

	public void SetNavigationData(NavigationData data)
	{
		navigationData = data;
	}

	public void SetAuthoringLines(List<NavigationAuthoringLine> lines)
	{
		authoringLines = lines ?? new List<NavigationAuthoringLine>();
	}

	public void ClearAuthoringLines()
	{
		authoringLines.Clear();
	}

	public void SetHandEditRoot(GameObject root)
	{
		handEditRoot = root;
	}
}
