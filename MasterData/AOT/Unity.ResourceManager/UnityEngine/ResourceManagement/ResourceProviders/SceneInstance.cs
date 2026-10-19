using System;
using UnityEngine.SceneManagement;

namespace UnityEngine.ResourceManagement.ResourceProviders;

public struct SceneInstance
{
	private Scene m_Scene;

	internal AsyncOperation m_Operation;

	public Scene Scene
	{
		get
		{
			return m_Scene;
		}
		internal set
		{
			m_Scene = value;
		}
	}

	[Obsolete("Activate() has been deprecated.  Please use ActivateAsync().")]
	public void Activate()
	{
		m_Operation.allowSceneActivation = true;
	}

	public AsyncOperation ActivateAsync()
	{
		m_Operation.allowSceneActivation = true;
		return m_Operation;
	}

	public override int GetHashCode()
	{
		return Scene.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		if (!(obj is SceneInstance))
		{
			return false;
		}
		return Scene.Equals(((SceneInstance)obj).Scene);
	}
}
