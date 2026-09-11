using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class Matrix4x4Formatter : IMessagePackFormatter<Matrix4x4>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Matrix4x4 value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(16);
		writer.Write(value.m00);
		writer.Write(value.m10);
		writer.Write(value.m20);
		writer.Write(value.m30);
		writer.Write(value.m01);
		writer.Write(value.m11);
		writer.Write(value.m21);
		writer.Write(value.m31);
		writer.Write(value.m02);
		writer.Write(value.m12);
		writer.Write(value.m22);
		writer.Write(value.m32);
		writer.Write(value.m03);
		writer.Write(value.m13);
		writer.Write(value.m23);
		writer.Write(value.m33);
	}

	public Matrix4x4 Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		float m = 0f;
		float m2 = 0f;
		float m3 = 0f;
		float m4 = 0f;
		float m5 = 0f;
		float m6 = 0f;
		float m7 = 0f;
		float m8 = 0f;
		float m9 = 0f;
		float m10 = 0f;
		float m11 = 0f;
		float m12 = 0f;
		float m13 = 0f;
		float m14 = 0f;
		float m15 = 0f;
		float m16 = 0f;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				m = reader.ReadSingle();
				break;
			case 1:
				m2 = reader.ReadSingle();
				break;
			case 2:
				m3 = reader.ReadSingle();
				break;
			case 3:
				m4 = reader.ReadSingle();
				break;
			case 4:
				m5 = reader.ReadSingle();
				break;
			case 5:
				m6 = reader.ReadSingle();
				break;
			case 6:
				m7 = reader.ReadSingle();
				break;
			case 7:
				m8 = reader.ReadSingle();
				break;
			case 8:
				m9 = reader.ReadSingle();
				break;
			case 9:
				m10 = reader.ReadSingle();
				break;
			case 10:
				m11 = reader.ReadSingle();
				break;
			case 11:
				m12 = reader.ReadSingle();
				break;
			case 12:
				m13 = reader.ReadSingle();
				break;
			case 13:
				m14 = reader.ReadSingle();
				break;
			case 14:
				m15 = reader.ReadSingle();
				break;
			case 15:
				m16 = reader.ReadSingle();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return new Matrix4x4
		{
			m00 = m,
			m10 = m2,
			m20 = m3,
			m30 = m4,
			m01 = m5,
			m11 = m6,
			m21 = m7,
			m31 = m8,
			m02 = m9,
			m12 = m10,
			m22 = m11,
			m32 = m12,
			m03 = m13,
			m13 = m14,
			m23 = m15,
			m33 = m16
		};
	}
}
