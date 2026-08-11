namespace Spine;

public interface AttachmentLoader
{
	RegionAttachment NewRegionAttachment(Skin skin, string name, string path, Sequence sequence);

	MeshAttachment NewMeshAttachment(Skin skin, string name, string path, Sequence sequence);

	BoundingBoxAttachment NewBoundingBoxAttachment(Skin skin, string name);

	PathAttachment NewPathAttachment(Skin skin, string name);

	PointAttachment NewPointAttachment(Skin skin, string name);

	ClippingAttachment NewClippingAttachment(Skin skin, string name);
}
