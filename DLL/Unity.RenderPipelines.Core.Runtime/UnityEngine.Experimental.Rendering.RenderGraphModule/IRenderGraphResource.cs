namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal class IRenderGraphResource
{
	public bool imported;

	public bool shared;

	public bool sharedExplicitRelease;

	public bool requestFallBack;

	public uint writeCount;

	public int cachedHash;

	public int transientPassIndex;

	public int sharedResourceLastFrameUsed;

	protected IRenderGraphResourcePool m_Pool;

	public virtual void Reset(IRenderGraphResourcePool pool)
	{
		imported = false;
		shared = false;
		sharedExplicitRelease = false;
		cachedHash = -1;
		transientPassIndex = -1;
		sharedResourceLastFrameUsed = -1;
		requestFallBack = false;
		writeCount = 0u;
		m_Pool = pool;
	}

	public virtual string GetName()
	{
		return "";
	}

	public virtual bool IsCreated()
	{
		return false;
	}

	public virtual void IncrementWriteCount()
	{
		writeCount++;
	}

	public virtual bool NeedsFallBack()
	{
		if (requestFallBack)
		{
			return writeCount == 0;
		}
		return false;
	}

	public virtual void CreatePooledGraphicsResource()
	{
	}

	public virtual void CreateGraphicsResource(string name = "")
	{
	}

	public virtual void ReleasePooledGraphicsResource(int frameIndex)
	{
	}

	public virtual void ReleaseGraphicsResource()
	{
	}

	public virtual void LogCreation(RenderGraphLogger logger)
	{
	}

	public virtual void LogRelease(RenderGraphLogger logger)
	{
	}

	public virtual int GetSortIndex()
	{
		return 0;
	}
}
