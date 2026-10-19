using System;

namespace UnityEngine.Rendering.Universal;

internal class SharedDecalEntityManager : IDisposable
{
	private DecalEntityManager m_DecalEntityManager;

	private int m_ReferenceCounter;

	public DecalEntityManager Get()
	{
		if (m_DecalEntityManager == null)
		{
			m_DecalEntityManager = new DecalEntityManager();
			DecalProjector[] array = Object.FindObjectsOfType<DecalProjector>();
			foreach (DecalProjector decalProjector in array)
			{
				if (decalProjector.isActiveAndEnabled && !m_DecalEntityManager.IsValid(decalProjector.decalEntity))
				{
					decalProjector.decalEntity = m_DecalEntityManager.CreateDecalEntity(decalProjector);
				}
			}
			DecalProjector.onDecalAdd += OnDecalAdd;
			DecalProjector.onDecalRemove += OnDecalRemove;
			DecalProjector.onDecalPropertyChange += OnDecalPropertyChange;
			DecalProjector.onDecalMaterialChange += OnDecalMaterialChange;
		}
		m_ReferenceCounter++;
		return m_DecalEntityManager;
	}

	public void Release(DecalEntityManager decalEntityManager)
	{
		if (m_ReferenceCounter != 0)
		{
			m_ReferenceCounter--;
			if (m_ReferenceCounter == 0)
			{
				Dispose();
			}
		}
	}

	public void Dispose()
	{
		m_DecalEntityManager.Dispose();
		m_DecalEntityManager = null;
		m_ReferenceCounter = 0;
		DecalProjector.onDecalAdd -= OnDecalAdd;
		DecalProjector.onDecalRemove -= OnDecalRemove;
		DecalProjector.onDecalPropertyChange -= OnDecalPropertyChange;
		DecalProjector.onDecalMaterialChange -= OnDecalMaterialChange;
	}

	private void OnDecalAdd(DecalProjector decalProjector)
	{
		if (!m_DecalEntityManager.IsValid(decalProjector.decalEntity))
		{
			decalProjector.decalEntity = m_DecalEntityManager.CreateDecalEntity(decalProjector);
		}
	}

	private void OnDecalRemove(DecalProjector decalProjector)
	{
		m_DecalEntityManager.DestroyDecalEntity(decalProjector.decalEntity);
	}

	private void OnDecalPropertyChange(DecalProjector decalProjector)
	{
		if (m_DecalEntityManager.IsValid(decalProjector.decalEntity))
		{
			m_DecalEntityManager.UpdateDecalEntityData(decalProjector.decalEntity, decalProjector);
		}
	}

	private void OnDecalMaterialChange(DecalProjector decalProjector)
	{
		OnDecalRemove(decalProjector);
		OnDecalAdd(decalProjector);
	}
}
