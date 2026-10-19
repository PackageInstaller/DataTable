namespace ACT.World.Asset;

public interface IDataBaker
{
	object baker { get; set; }

	IDataToBake LastBakedData { get; }
}
