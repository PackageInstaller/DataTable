namespace Oath;

public class OathInterationManager
{
	public OathCharacter character;

	private OathCharacterData characterData;

	public void Init()
	{
		characterData = Asset.Load<OathCharacterData>(OathConst.GetCharacterDataPath(OathSceneLoader.Scene.context.characterID));
		character = new OathCharacter();
		character.Init(characterData);
	}

	public void Tick()
	{
		character?.Tick();
	}

	public void Dispose()
	{
		character.Dispose();
		character = null;
	}

	public void InvokeSkip()
	{
		foreach (OathInteractionBaseData interationEvent in character.eventContext.interationEventList)
		{
			if (interationEvent is OathInteractcionSkip)
			{
				interationEvent.IsFinish = true;
				break;
			}
		}
	}
}
