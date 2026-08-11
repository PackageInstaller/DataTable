#define ENABLE_DEBUG_AND_ABOVE_LOG
#define ENABLE_INFO_AND_ABOVE_LOG
#define ENABLE_WARNING_AND_ABOVE_LOG
#define ENABLE_FATAL_AND_ABOVE_LOG
using System;
using System.IO;
using System.Text;
using GameFramework.DataTable;
using UnityEngine;

namespace GameFramework.Runtime;

public class DefaultDataTableHelper : DataTableHelperBase
{
	private static readonly string BytesAssetExtension = ".bytes";

	private ResourceComponent m_ResourceComponent = null;

	public override bool ReadData(DataTableBase dataTable, string dataTableAssetName, object dataTableAsset, object userData)
	{
		TextAsset textAsset = dataTableAsset as TextAsset;
		if (textAsset != null)
		{
			if (dataTableAssetName.EndsWith(BytesAssetExtension, StringComparison.Ordinal))
			{
				return dataTable.ParseData(textAsset.bytes, userData);
			}
			return dataTable.ParseData(textAsset.text, userData);
		}
		Log.Warning("Data table asset '{0}' is invalid.", dataTableAssetName);
		return false;
	}

	public override bool ReadData(DataTableBase dataTable, string dataTableAssetName, byte[] dataTableBytes, int startIndex, int length, object userData)
	{
		if (dataTableAssetName.EndsWith(BytesAssetExtension, StringComparison.Ordinal))
		{
			return dataTable.ParseData(dataTableBytes, startIndex, length, userData);
		}
		return dataTable.ParseData(Utility.Converter.GetString(dataTableBytes, startIndex, length), userData);
	}

	public override bool ParseData(DataTableBase dataTable, string dataTableString, object userData)
	{
		try
		{
			int position = 0;
			string text = null;
			while ((text = dataTableString.ReadLine(ref position)) != null)
			{
				if (text[0] == '#' || dataTable.AddDataRow(text, userData))
				{
					continue;
				}
				Log.Warning("Can not parse data row string '{0}'.", text);
				return false;
			}
			return true;
		}
		catch (Exception arg)
		{
			Log.Error("Can not parse data table string with exception '{0}'.", arg);
			return false;
		}
	}

	public override bool ParseData(DataTableBase dataTable, byte[] dataTableBytes, int startIndex, int length, object userData)
	{
		try
		{
			using (MemoryStream input = new MemoryStream(dataTableBytes, startIndex, length, writable: false))
			{
				using BinaryReader binaryReader = new BinaryReader(input, Encoding.UTF8);
				while (binaryReader.BaseStream.Position < binaryReader.BaseStream.Length)
				{
					int num = binaryReader.Read7BitEncodedInt32();
					if (!dataTable.AddDataRow(dataTableBytes, (int)binaryReader.BaseStream.Position, num, userData))
					{
						Log.Warning("Can not parse data row bytes.");
						return false;
					}
					binaryReader.BaseStream.Position += num;
				}
			}
			return true;
		}
		catch (Exception arg)
		{
			Log.Warning("Can not parse dictionary bytes with exception '{0}'.", arg);
			return false;
		}
	}

	public override void ReleaseDataAsset(DataTableBase dataTable, string dataTableAsset, string packageName)
	{
		m_ResourceComponent.UnloadAsset(dataTableAsset, packageName);
	}

	private void Start()
	{
		m_ResourceComponent = GameEntryRuntime.GetComponent<ResourceComponent>();
		if (m_ResourceComponent == null)
		{
			Log.Fatal("Resource component is invalid.");
		}
	}
}
