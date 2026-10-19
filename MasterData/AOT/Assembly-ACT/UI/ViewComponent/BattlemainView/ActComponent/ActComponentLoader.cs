using System;
using ACT;
using ACT.UI;
using ACT.Utility;
using Bamboo.AssetField;
using UnityEngine;

namespace UI.ViewComponent.BattlemainView.ActComponent;

public class ActComponentLoader : MonoBehaviour, IUIFrameElement
{
	public YooAssetReference assetReferenceAssetID;

	protected IBaseUIView m_UIView;

	protected AssetLoadHandle m_ObjectHandler;

	public void Initialize()
	{
		m_UIView = ((IUIFrameElement)this).GetParentView();
		if (m_UIView == null)
		{
			_ = LuminApplication.LogEnabled;
		}
		else
		{
			if (m_ObjectHandler.IsValid)
			{
				return;
			}
			m_ObjectHandler = AssetStationManager.BattleStation.InstantiateAsync(assetReferenceAssetID, transform, instantiateInWorldSpace: false, (AssetLoadHandle result) =>
			{
				if (result.IsValid)
				{
					try
					{
						ActComponent component = result.AsGameObject().GetComponent<ActComponent>();
						component.OnLoadComplete(m_UIView);
						m_UIView.uiComponents.TryAdd(component);
					}
					catch (Exception exception)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogException(exception);
						}
					}
				}
			});
		}
	}

	public void UnInitialize()
	{
		if (m_UIView == null)
		{
			_ = LuminApplication.LogEnabled;
		}
		else
		{
			if (!m_ObjectHandler.IsValid || m_ObjectHandler.Result == null)
			{
				return;
			}
			if (m_ObjectHandler.State == LoadState.Success)
			{
				ActComponent component = m_ObjectHandler.AsGameObject().GetComponent<ActComponent>();
				if (component != null)
				{
					component.BeforeDestroy();
				}
				ReleaseActComponent(component);
			}
			else
			{
				AssetStationManager.BattleStation.ReleaseInstance(m_ObjectHandler);
			}
		}
	}

	private void ReleaseActComponent(ActComponent component)
	{
		try
		{
			m_UIView.uiComponents.TryRemove(component);
			AssetStationManager.BattleStation.ReleaseInstance(m_ObjectHandler);
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
	}
}
