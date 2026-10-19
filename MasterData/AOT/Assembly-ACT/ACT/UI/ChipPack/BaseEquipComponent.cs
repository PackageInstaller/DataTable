using ACT.Game.Data;

namespace ACT.UI.ChipPack;

public class BaseEquipComponent : BaseUIComponent
{
	public bool isOpen;

	public Character character { get; set; }

	public virtual void Awake()
	{
	}

	public virtual void Open(Character character)
	{
		this.character = character;
		if (!isOpen)
		{
			isOpen = true;
			gameObject.SetActive(value: true);
		}
	}

	public virtual void Init(object date)
	{
	}

	public virtual void Close()
	{
		if (isOpen)
		{
			isOpen = false;
			gameObject.SetActive(value: false);
		}
	}
}
