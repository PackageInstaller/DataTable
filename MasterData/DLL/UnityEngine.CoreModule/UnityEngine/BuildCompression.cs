using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[Serializable]
[UsedByNativeCode]
public struct BuildCompression
{
	public static readonly BuildCompression Uncompressed = new BuildCompression(CompressionType.None, CompressionLevel.Maximum, 131072u);

	public static readonly BuildCompression LZ4 = new BuildCompression(CompressionType.Lz4HC, CompressionLevel.Maximum, 131072u);

	public static readonly BuildCompression LZMA = new BuildCompression(CompressionType.Lzma, CompressionLevel.Maximum, 131072u);

	public static readonly BuildCompression UncompressedRuntime = Uncompressed;

	public static readonly BuildCompression LZ4Runtime = new BuildCompression(CompressionType.Lz4, CompressionLevel.Maximum, 131072u);

	[NativeName("compression")]
	private CompressionType _compression;

	[NativeName("level")]
	private CompressionLevel _level;

	[NativeName("blockSize")]
	private uint _blockSize;

	[NativeName("enableProtect")]
	private bool _enableProtect;

	public CompressionType compression
	{
		get
		{
			return _compression;
		}
		private set
		{
			_compression = value;
		}
	}

	public CompressionLevel level
	{
		get
		{
			return _level;
		}
		private set
		{
			_level = value;
		}
	}

	public uint blockSize
	{
		get
		{
			return _blockSize;
		}
		private set
		{
			_blockSize = value;
		}
	}

	public bool enableProtect
	{
		get
		{
			return _enableProtect;
		}
		private set
		{
			_enableProtect = value;
		}
	}

	private BuildCompression(CompressionType in_compression, CompressionLevel in_level, uint in_blockSize)
	{
		this = default(BuildCompression);
		compression = in_compression;
		level = in_level;
		blockSize = in_blockSize;
		enableProtect = false;
	}
}
