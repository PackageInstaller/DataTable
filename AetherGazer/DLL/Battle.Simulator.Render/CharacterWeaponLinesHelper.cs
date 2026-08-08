using System.Collections.Generic;
using UnityEngine;

public class CharacterWeaponLinesHelper : MonoBehaviour
{
	public int LineInitState;

	public List<LineConfig> lineConfigs = new List<LineConfig>();

	public void Initialize(List<LineConnectionConfig> configs, AttachPointSetup attachPointSetup, int initState = 0)
	{
		for (int i = 0; i < configs.Count; i++)
		{
			LineConnectionConfig lineConnectionConfig = configs[i];
			LineConfig lineConfig = new LineConfig();
			GameObject gameObject = Asset.Instantiate(lineConnectionConfig.LineEffectPath);
			if (gameObject != null)
			{
				lineConfig.StartTransform = attachPointSetup.GetAttachPoint(lineConnectionConfig.StartPath);
				lineConfig.EndTransform = attachPointSetup.GetAttachPoint(lineConnectionConfig.EndPath);
				lineConfig.Rope = U3DUtil.Get<SpringCurve>(gameObject);
				lineConfig.Rope.Initialize();
				lineConfig.Rope.From = lineConfig.StartTransform.position;
				lineConfig.Rope.To = lineConfig.EndTransform.position;
			}
			lineConfigs.Add(lineConfig);
		}
		LineInitState = initState;
		ShowLine();
	}

	private void Update()
	{
		for (int i = 0; i < lineConfigs.Count; i++)
		{
			LineConfig lineConfig = lineConfigs[i];
			if (lineConfig.Rope != null)
			{
				lineConfig.Rope.From = lineConfig.StartTransform.position;
				lineConfig.Rope.To = lineConfig.EndTransform.position;
			}
		}
	}

	private void OnDestroy()
	{
		for (int i = 0; i < lineConfigs.Count; i++)
		{
			lineConfigs[i].Rope = null;
		}
		lineConfigs.Clear();
	}

	public void ShowLine(int showConfig = -1)
	{
		if (showConfig == -1)
		{
			showConfig = LineInitState;
		}
		for (int i = 0; i < lineConfigs.Count; i++)
		{
			bool show = ((showConfig >> i) & 1) == 1;
			if (lineConfigs[i].Rope != null)
			{
				lineConfigs[i].Rope.ShowLine(show);
			}
		}
	}
}
