using System.Collections.Generic;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal class RenderGraphDebugParams
{
	private static class Strings
	{
		public static readonly DebugUI.Widget.NameAndTooltip ClearRenderTargetsAtCreation = new DebugUI.Widget.NameAndTooltip
		{
			name = "Clear Render Targets At Creation",
			tooltip = "Enable to clear all render textures before any rendergraph passes to check if some clears are missing."
		};

		public static readonly DebugUI.Widget.NameAndTooltip DisablePassCulling = new DebugUI.Widget.NameAndTooltip
		{
			name = "Disable Pass Culling",
			tooltip = "Enable to temporarily disable culling to asses if a pass is culled."
		};

		public static readonly DebugUI.Widget.NameAndTooltip ImmediateMode = new DebugUI.Widget.NameAndTooltip
		{
			name = "Immediate Mode",
			tooltip = "Enable to force render graph to execute all passes in the order you registered them."
		};

		public static readonly DebugUI.Widget.NameAndTooltip EnableLogging = new DebugUI.Widget.NameAndTooltip
		{
			name = "Enable Logging",
			tooltip = "Enable to allow HDRP to capture information in the log."
		};

		public static readonly DebugUI.Widget.NameAndTooltip LogFrameInformation = new DebugUI.Widget.NameAndTooltip
		{
			name = "Log Frame Information",
			tooltip = "Enable to log information output from each frame."
		};

		public static readonly DebugUI.Widget.NameAndTooltip LogResources = new DebugUI.Widget.NameAndTooltip
		{
			name = "Log Resources",
			tooltip = "Enable to log the current render graph's global resource usage."
		};
	}

	private DebugUI.Widget[] m_DebugItems;

	private DebugUI.Panel m_DebugPanel;

	public bool clearRenderTargetsAtCreation;

	public bool clearRenderTargetsAtRelease;

	public bool disablePassCulling;

	public bool immediateMode;

	public bool enableLogging;

	public bool logFrameInformation;

	public bool logResources;

	public void RegisterDebug(string name, DebugUI.Panel debugPanel = null)
	{
		List<DebugUI.Widget> list = new List<DebugUI.Widget>();
		list.Add(new DebugUI.Container
		{
			displayName = name + " Render Graph",
			children = 
			{
				(DebugUI.Widget)new DebugUI.BoolField
				{
					nameAndTooltip = Strings.ClearRenderTargetsAtCreation,
					getter = () => clearRenderTargetsAtCreation,
					setter = delegate(bool value)
					{
						clearRenderTargetsAtCreation = value;
					}
				},
				(DebugUI.Widget)new DebugUI.BoolField
				{
					nameAndTooltip = Strings.DisablePassCulling,
					getter = () => disablePassCulling,
					setter = delegate(bool value)
					{
						disablePassCulling = value;
					}
				},
				(DebugUI.Widget)new DebugUI.BoolField
				{
					nameAndTooltip = Strings.ImmediateMode,
					getter = () => immediateMode,
					setter = delegate(bool value)
					{
						immediateMode = value;
					}
				},
				(DebugUI.Widget)new DebugUI.BoolField
				{
					nameAndTooltip = Strings.EnableLogging,
					getter = () => enableLogging,
					setter = delegate(bool value)
					{
						enableLogging = value;
					}
				},
				(DebugUI.Widget)new DebugUI.Button
				{
					nameAndTooltip = Strings.LogFrameInformation,
					action = delegate
					{
						if (!enableLogging)
						{
							Debug.Log("You must first enable logging before this logging frame information.");
						}
						logFrameInformation = true;
					}
				},
				(DebugUI.Widget)new DebugUI.Button
				{
					nameAndTooltip = Strings.LogResources,
					action = delegate
					{
						if (!enableLogging)
						{
							Debug.Log("You must first enable logging before this logging resources.");
						}
						logResources = true;
					}
				}
			}
		});
		m_DebugItems = list.ToArray();
		m_DebugPanel = ((debugPanel != null) ? debugPanel : DebugManager.instance.GetPanel((name.Length == 0) ? "Render Graph" : name, createIfNull: true));
		m_DebugPanel.children.Add(m_DebugItems);
	}

	public void UnRegisterDebug(string name)
	{
		m_DebugPanel.children.Remove(m_DebugItems);
		m_DebugPanel = null;
		m_DebugItems = null;
	}
}
