namespace Pathfinding.Voxels;

public struct CompactVoxelSpan(ushort bottom, uint height)
{
	public ushort y = bottom;

	public uint con = 24u;

	public uint h = height;

	public int reg = 0;

	public void SetConnection(int dir, uint value)
	{
		int num = dir * 6;
		con = (uint)((con & ~(63 << num)) | ((value & 0x3F) << num));
	}

	public int GetConnection(int dir)
	{
		return ((int)con >> dir * 6) & 0x3F;
	}
}
