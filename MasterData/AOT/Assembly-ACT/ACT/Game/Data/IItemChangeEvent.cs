using Google.Protobuf.Collections;

namespace ACT.Game.Data;

public interface IItemChangeEvent
{
	void TakeOff(MapField<int, Character> characters, CharacterDependSnapshot depend);

	void Wear(MapField<int, Character> characters, CharacterDependSnapshot depend);

	void RefreshItemInfo();
}
