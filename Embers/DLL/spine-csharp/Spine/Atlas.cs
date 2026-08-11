using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;

namespace Spine;

public class Atlas : IEnumerable<AtlasRegion>, IEnumerable
{
	private readonly List<AtlasPage> pages = new List<AtlasPage>();

	private List<AtlasRegion> regions = new List<AtlasRegion>();

	private TextureLoader textureLoader;

	public List<AtlasRegion> Regions => regions;

	public List<AtlasPage> Pages => pages;

	public IEnumerator<AtlasRegion> GetEnumerator()
	{
		return regions.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return regions.GetEnumerator();
	}

	public Atlas(List<AtlasPage> pages, List<AtlasRegion> regions)
	{
		if (pages == null)
		{
			throw new ArgumentNullException("pages", "pages cannot be null.");
		}
		if (regions == null)
		{
			throw new ArgumentNullException("regions", "regions cannot be null.");
		}
		this.pages = pages;
		this.regions = regions;
		textureLoader = null;
	}

	public Atlas(TextReader reader, string imagesDir, TextureLoader textureLoader)
	{
		if (reader == null)
		{
			throw new ArgumentNullException("reader", "reader cannot be null.");
		}
		if (imagesDir == null)
		{
			throw new ArgumentNullException("imagesDir", "imagesDir cannot be null.");
		}
		if (textureLoader == null)
		{
			throw new ArgumentNullException("textureLoader", "textureLoader cannot be null.");
		}
		this.textureLoader = textureLoader;
		string[] entry = new string[5];
		AtlasPage page = null;
		AtlasRegion region = null;
		Dictionary<string, Action> dictionary = new Dictionary<string, Action>(5)
		{
			{
				"size",
				delegate
				{
					page.width = int.Parse(entry[1], CultureInfo.InvariantCulture);
					page.height = int.Parse(entry[2], CultureInfo.InvariantCulture);
				}
			},
			{
				"format",
				delegate
				{
					page.format = (Format)Enum.Parse(typeof(Format), entry[1], ignoreCase: false);
				}
			},
			{
				"filter",
				delegate
				{
					page.minFilter = (TextureFilter)Enum.Parse(typeof(TextureFilter), entry[1], ignoreCase: false);
					page.magFilter = (TextureFilter)Enum.Parse(typeof(TextureFilter), entry[2], ignoreCase: false);
				}
			},
			{
				"repeat",
				delegate
				{
					if (entry[1].IndexOf('x') != -1)
					{
						page.uWrap = TextureWrap.Repeat;
					}
					if (entry[1].IndexOf('y') != -1)
					{
						page.vWrap = TextureWrap.Repeat;
					}
				}
			},
			{
				"pma",
				delegate
				{
					page.pma = entry[1] == "true";
				}
			}
		};
		Dictionary<string, Action> dictionary2 = new Dictionary<string, Action>(8)
		{
			{
				"xy",
				delegate
				{
					region.x = int.Parse(entry[1], CultureInfo.InvariantCulture);
					region.y = int.Parse(entry[2], CultureInfo.InvariantCulture);
				}
			},
			{
				"size",
				delegate
				{
					region.width = int.Parse(entry[1], CultureInfo.InvariantCulture);
					region.height = int.Parse(entry[2], CultureInfo.InvariantCulture);
				}
			},
			{
				"bounds",
				delegate
				{
					region.x = int.Parse(entry[1], CultureInfo.InvariantCulture);
					region.y = int.Parse(entry[2], CultureInfo.InvariantCulture);
					region.width = int.Parse(entry[3], CultureInfo.InvariantCulture);
					region.height = int.Parse(entry[4], CultureInfo.InvariantCulture);
				}
			},
			{
				"offset",
				delegate
				{
					region.offsetX = int.Parse(entry[1], CultureInfo.InvariantCulture);
					region.offsetY = int.Parse(entry[2], CultureInfo.InvariantCulture);
				}
			},
			{
				"orig",
				delegate
				{
					region.originalWidth = int.Parse(entry[1], CultureInfo.InvariantCulture);
					region.originalHeight = int.Parse(entry[2], CultureInfo.InvariantCulture);
				}
			},
			{
				"offsets",
				delegate
				{
					region.offsetX = int.Parse(entry[1], CultureInfo.InvariantCulture);
					region.offsetY = int.Parse(entry[2], CultureInfo.InvariantCulture);
					region.originalWidth = int.Parse(entry[3], CultureInfo.InvariantCulture);
					region.originalHeight = int.Parse(entry[4], CultureInfo.InvariantCulture);
				}
			},
			{
				"rotate",
				delegate
				{
					string text2 = entry[1];
					if (text2 == "true")
					{
						region.degrees = 90;
					}
					else if (text2 != "false")
					{
						region.degrees = int.Parse(text2, CultureInfo.InvariantCulture);
					}
				}
			},
			{
				"index",
				delegate
				{
					region.index = int.Parse(entry[1], CultureInfo.InvariantCulture);
				}
			}
		};
		string text = reader.ReadLine();
		while (text != null && text.Trim().Length == 0)
		{
			text = reader.ReadLine();
		}
		while (text != null && text.Trim().Length != 0 && ReadEntry(entry, text) != 0)
		{
			text = reader.ReadLine();
		}
		List<string> list = null;
		List<int[]> list2 = null;
		while (text != null)
		{
			if (text.Trim().Length == 0)
			{
				page = null;
				text = reader.ReadLine();
				continue;
			}
			if (page == null)
			{
				page = new AtlasPage();
				page.name = text.Trim();
				while (ReadEntry(entry, text = reader.ReadLine()) != 0)
				{
					if (dictionary.TryGetValue(entry[0], out var value))
					{
						value();
					}
				}
				textureLoader.Load(page, Path.Combine(imagesDir, page.name));
				pages.Add(page);
				continue;
			}
			region = new AtlasRegion();
			region.page = page;
			region.name = text;
			while (true)
			{
				int num = ReadEntry(entry, text = reader.ReadLine());
				if (num == 0)
				{
					break;
				}
				if (dictionary2.TryGetValue(entry[0], out var value2))
				{
					value2();
					continue;
				}
				if (list == null)
				{
					list = new List<string>(8);
					list2 = new List<int[]>(8);
				}
				list.Add(entry[0]);
				int[] array = new int[num];
				for (int num2 = 0; num2 < num; num2++)
				{
					int.TryParse(entry[num2 + 1], NumberStyles.Any, CultureInfo.InvariantCulture, out array[num2]);
				}
				list2.Add(array);
			}
			if (region.originalWidth == 0 && region.originalHeight == 0)
			{
				region.originalWidth = region.width;
				region.originalHeight = region.height;
			}
			if (list != null && list.Count > 0)
			{
				region.names = list.ToArray();
				region.values = list2.ToArray();
				list.Clear();
				list2.Clear();
			}
			region.u = (float)region.x / (float)page.width;
			region.v = (float)region.y / (float)page.height;
			if (region.degrees == 90)
			{
				region.u2 = (float)(region.x + region.height) / (float)page.width;
				region.v2 = (float)(region.y + region.width) / (float)page.height;
				int packedWidth = region.packedWidth;
				region.packedWidth = region.packedHeight;
				region.packedHeight = packedWidth;
			}
			else
			{
				region.u2 = (float)(region.x + region.width) / (float)page.width;
				region.v2 = (float)(region.y + region.height) / (float)page.height;
			}
			regions.Add(region);
		}
	}

	private static int ReadEntry(string[] entry, string line)
	{
		if (line == null)
		{
			return 0;
		}
		line = line.Trim();
		if (line.Length == 0)
		{
			return 0;
		}
		int num = line.IndexOf(':');
		if (num == -1)
		{
			return 0;
		}
		entry[0] = line.Substring(0, num).Trim();
		int num2 = 1;
		int num3 = num + 1;
		while (true)
		{
			int num4 = line.IndexOf(',', num3);
			if (num4 == -1)
			{
				entry[num2] = line.Substring(num3).Trim();
				return num2;
			}
			entry[num2] = line.Substring(num3, num4 - num3).Trim();
			num3 = num4 + 1;
			if (num2 == 4)
			{
				break;
			}
			num2++;
		}
		return 4;
	}

	public void FlipV()
	{
		int i = 0;
		for (int count = regions.Count; i < count; i++)
		{
			AtlasRegion atlasRegion = regions[i];
			atlasRegion.v = 1f - atlasRegion.v;
			atlasRegion.v2 = 1f - atlasRegion.v2;
		}
	}

	public AtlasRegion FindRegion(string name)
	{
		int i = 0;
		for (int count = regions.Count; i < count; i++)
		{
			if (regions[i].name == name)
			{
				return regions[i];
			}
		}
		return null;
	}

	public void Dispose()
	{
		if (textureLoader != null)
		{
			int i = 0;
			for (int count = pages.Count; i < count; i++)
			{
				textureLoader.Unload(pages[i].rendererObject);
			}
		}
	}
}
