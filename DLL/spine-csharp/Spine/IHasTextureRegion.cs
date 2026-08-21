namespace Spine;

public interface IHasTextureRegion
{
	string Path { get; set; }

	TextureRegion Region { get; set; }

	float R { get; set; }

	float G { get; set; }

	float B { get; set; }

	float A { get; set; }

	Sequence Sequence { get; set; }

	void UpdateRegion();
}
