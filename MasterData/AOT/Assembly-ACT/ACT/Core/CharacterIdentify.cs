namespace ACT.Core;

public struct CharacterIdentify(int sceneStatusIndex = -1, bool isTrailCharacter = false)
{
	public int SceneStatusIndex = sceneStatusIndex;

	public bool IsTrailCharacter = isTrailCharacter;

	public static readonly CharacterIdentify Default = new CharacterIdentify(0);
}
