using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class UnityEngine_TextGeneratorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TextGenerator), typeof(object));
		L.RegFunction("Invalidate", Invalidate);
		L.RegFunction("GetCharacters", GetCharacters);
		L.RegFunction("GetLines", GetLines);
		L.RegFunction("GetVertices", GetVertices);
		L.RegFunction("GetPreferredWidth", GetPreferredWidth);
		L.RegFunction("GetPreferredHeight", GetPreferredHeight);
		L.RegFunction("PopulateWithErrors", PopulateWithErrors);
		L.RegFunction("Populate", Populate);
		L.RegFunction("GetVerticesArray", GetVerticesArray);
		L.RegFunction("GetCharactersArray", GetCharactersArray);
		L.RegFunction("GetLinesArray", GetLinesArray);
		L.RegFunction("New", _CreateUnityEngine_TextGenerator);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("characterCountVisible", get_characterCountVisible, null);
		L.RegVar("verts", get_verts, null);
		L.RegVar("characters", get_characters, null);
		L.RegVar("lines", get_lines, null);
		L.RegVar("rectExtents", get_rectExtents, null);
		L.RegVar("vertexCount", get_vertexCount, null);
		L.RegVar("characterCount", get_characterCount, null);
		L.RegVar("lineCount", get_lineCount, null);
		L.RegVar("fontSizeUsedForBestFit", get_fontSizeUsedForBestFit, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_TextGenerator(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				TextGenerator o2 = new TextGenerator();
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 1:
			{
				TextGenerator o = new TextGenerator((int)LuaDLL.luaL_checknumber(L, 1));
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.TextGenerator.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Invalidate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator))).Invalidate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCharacters(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TextGenerator obj = (TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator));
			List<UICharInfo> characters = (List<UICharInfo>)ToLua.CheckObject(L, 2, typeof(List<UICharInfo>));
			obj.GetCharacters(characters);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLines(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TextGenerator obj = (TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator));
			List<UILineInfo> lines = (List<UILineInfo>)ToLua.CheckObject(L, 2, typeof(List<UILineInfo>));
			obj.GetLines(lines);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVertices(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TextGenerator obj = (TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator));
			List<UIVertex> vertices = (List<UIVertex>)ToLua.CheckObject(L, 2, typeof(List<UIVertex>));
			obj.GetVertices(vertices);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPreferredWidth(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			TextGenerator obj = (TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator));
			string str = ToLua.CheckString(L, 2);
			TextGenerationSettings settings = StackTraits<TextGenerationSettings>.Check(L, 3);
			float preferredWidth = obj.GetPreferredWidth(str, settings);
			LuaDLL.lua_pushnumber(L, preferredWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPreferredHeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			TextGenerator obj = (TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator));
			string str = ToLua.CheckString(L, 2);
			TextGenerationSettings settings = StackTraits<TextGenerationSettings>.Check(L, 3);
			float preferredHeight = obj.GetPreferredHeight(str, settings);
			LuaDLL.lua_pushnumber(L, preferredHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PopulateWithErrors(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			TextGenerator obj = (TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator));
			string str = ToLua.CheckString(L, 2);
			TextGenerationSettings settings = StackTraits<TextGenerationSettings>.Check(L, 3);
			GameObject context = (GameObject)ToLua.CheckObject(L, 4, typeof(GameObject));
			bool value = obj.PopulateWithErrors(str, settings, context);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Populate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			TextGenerator obj = (TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator));
			string str = ToLua.CheckString(L, 2);
			TextGenerationSettings settings = StackTraits<TextGenerationSettings>.Check(L, 3);
			bool value = obj.Populate(str, settings);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVerticesArray(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UIVertex[] verticesArray = ((TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator))).GetVerticesArray();
			ToLua.Push(L, verticesArray);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCharactersArray(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UICharInfo[] charactersArray = ((TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator))).GetCharactersArray();
			ToLua.Push(L, charactersArray);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLinesArray(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UILineInfo[] linesArray = ((TextGenerator)ToLua.CheckObject(L, 1, typeof(TextGenerator))).GetLinesArray();
			ToLua.Push(L, linesArray);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_characterCountVisible(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int characterCountVisible = ((TextGenerator)obj).characterCountVisible;
			LuaDLL.lua_pushinteger(L, characterCountVisible);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterCountVisible on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_verts(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IList<UIVertex> verts = ((TextGenerator)obj).verts;
			ToLua.PushObject(L, verts);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verts on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_characters(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IList<UICharInfo> characters = ((TextGenerator)obj).characters;
			ToLua.PushObject(L, characters);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characters on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lines(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IList<UILineInfo> lines = ((TextGenerator)obj).lines;
			ToLua.PushObject(L, lines);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lines on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rectExtents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect rectExtents = ((TextGenerator)obj).rectExtents;
			ToLua.PushValue(L, rectExtents);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rectExtents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vertexCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int vertexCount = ((TextGenerator)obj).vertexCount;
			LuaDLL.lua_pushinteger(L, vertexCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vertexCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_characterCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int characterCount = ((TextGenerator)obj).characterCount;
			LuaDLL.lua_pushinteger(L, characterCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lineCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int lineCount = ((TextGenerator)obj).lineCount;
			LuaDLL.lua_pushinteger(L, lineCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lineCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fontSizeUsedForBestFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int fontSizeUsedForBestFit = ((TextGenerator)obj).fontSizeUsedForBestFit;
			LuaDLL.lua_pushinteger(L, fontSizeUsedForBestFit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fontSizeUsedForBestFit on a nil value");
		}
	}
}
