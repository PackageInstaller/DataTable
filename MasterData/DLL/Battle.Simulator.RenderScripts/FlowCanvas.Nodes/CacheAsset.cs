using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("缓存资源", 0)]
[Category("Render/Asset")]
[Description("如题")]
public class CacheAsset : CallableActionNode<string>
{
	public override void Invoke(string path)
	{
		Asset.Cache(path);
	}
}
