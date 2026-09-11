using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("加载场景(带设置loading图)", 0)]
[Category("Render/UI")]
[Description("加载场景,设置loading图,路径为TextureConfig/Loading(True)或TextureConfig/Background(False)下的图片")]
public class SetLoadingBackground : FlowNode
{
	private string path;

	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("id");
		ValueInput<bool> isLoadingPath = AddValueInput<bool>("是否读取loading目录").SetDefaultAndSerializedValue(v: true);
		ValueInput<string> pathInput = AddValueInput<string>("path").SetDefaultAndSerializedValue("loading_1");
		AddFlowInput("", delegate
		{
			NScene.GetCurrentScene();
			int value = idInput.value;
			path = pathInput.value;
			SceneDirector.Instance.Restart(value);
			string text;
			if (isLoadingPath.value)
			{
				text = "TextureConfig/Loading/" + path;
				LoadingUIManager.inst.SetBackground(path);
			}
			else
			{
				text = "TextureConfig/Background/" + path;
				LoadingUIManager.inst.SetBackground2(path);
			}
			if (AssetDownloadManager.CheckResourcesNeedDownload(new string[1] { text }))
			{
				AssetPendDownLoadManager.instance.AddPend(PendType.SingleAsset, text, delegate
				{
				}, delegate
				{
				}, delegate
				{
				});
			}
		});
	}
}
