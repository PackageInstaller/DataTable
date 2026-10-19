using Cysharp.Threading.Tasks;

namespace ACT.UI;

public class CharacterSecondViewBase : BaseUIView
{
	public int index;

	public async UniTask OpenSecondView()
	{
		await UICharacterScene.LoadPrefab();
		UICharacterScene.Push();
		UICharacterScene.instance.TurnToSecondCamera(isSecondView: true, index);
	}

	public void CloseSecondView()
	{
		UICharacterScene.instance.TurnToSecondCamera(isSecondView: false);
	}

	protected override void CloseComplete()
	{
		UICharacterScene.Pop();
	}
}
