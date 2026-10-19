using System;
using System.Collections.Generic;

namespace ACT.Model;

[Obsolete]
public class CharacterOperateBtnModel : Model<CharacterOperateBtnModel>
{
	private Dictionary<int, int> _characterEnergyStage2State;

	public Dictionary<int, int> characterEnergyStage2State
	{
		get
		{
			return _characterEnergyStage2State;
		}
		set
		{
			_characterEnergyStage2State = value;
		}
	}

	protected override void Init()
	{
		_characterEnergyStage2State = new Dictionary<int, int>();
	}

	protected override void UnInit()
	{
	}
}
