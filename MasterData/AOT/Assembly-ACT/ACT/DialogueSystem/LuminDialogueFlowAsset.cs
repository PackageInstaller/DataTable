using UnityEngine;

namespace ACT.DialogueSystem;

[CreateAssetMenu(menuName = "Dialogue", fileName = "New Dialogue", order = 0)]
public class LuminDialogueFlowAsset : DialogueFlowAsset<LuminDialogueFlow>
{
	protected void Reset()
	{
		data.root = new LuminDialogueRoot();
		((DialogueGroup)data.root.children[0]).title = "开始";
	}
}
