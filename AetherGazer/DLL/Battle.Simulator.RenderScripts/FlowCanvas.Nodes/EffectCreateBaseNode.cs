using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

public class EffectCreateBaseNode : FlowControlNode, IPreloadAsset
{
	protected ValueInput<string> _effectPathInput;

	protected GameObject _effectInstance;

	[Name("预加载个数（为0是则不进和地预加载）", 0)]
	public int CacheCount = 2;

	private bool cached;

	private string assetPath;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.WriteInt32(CacheCount);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		CacheCount = reader.ReadInt32();
	}

	protected override void RegisterPorts()
	{
		_effectPathInput = AddValueInput<string>("路径", "effectPathInput");
		AddValueOutput("Resource", "effect", () => _effectInstance);
		cached = false;
	}

	public string GetAssetPath()
	{
		return _effectPathInput.GetValue();
	}

	public int GetCacheCount()
	{
		return CacheCount;
	}

	public override void OnGraphStarted()
	{
		if (!cached && BattleSceneLoader.HasEnoughMemory())
		{
			assetPath = _effectPathInput.value;
			if (string.IsNullOrEmpty(assetPath) || CacheCount <= 0)
			{
				Debug.LogWarning(base.graph.name + " 的 " + name + " 节点路径为空");
			}
			else
			{
				Asset.Cache(_effectPathInput.value, CacheCount);
				cached = true;
			}
		}
		base.OnGraphStarted();
	}

	public override void OnDestroy()
	{
		base.OnDestroy();
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (_effectInstance != null)
		{
			PooledAsset.DestroyOrReturn(_effectInstance);
			_effectInstance = null;
		}
	}
}
