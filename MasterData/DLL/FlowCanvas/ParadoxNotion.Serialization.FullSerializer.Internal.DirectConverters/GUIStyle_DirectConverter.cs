using System;
using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer.Internal.DirectConverters;

public class GUIStyle_DirectConverter : fsDirectConverter<GUIStyle>
{
	protected override fsResult DoSerialize(GUIStyle model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "active", model.active) + SerializeMember(serialized, null, "alignment", model.alignment) + SerializeMember(serialized, null, "border", model.border) + SerializeMember(serialized, null, "clipping", model.clipping) + SerializeMember(serialized, null, "contentOffset", model.contentOffset) + SerializeMember(serialized, null, "fixedHeight", model.fixedHeight) + SerializeMember(serialized, null, "fixedWidth", model.fixedWidth) + SerializeMember(serialized, null, "focused", model.focused) + SerializeMember(serialized, null, "font", model.font) + SerializeMember(serialized, null, "fontSize", model.fontSize) + SerializeMember(serialized, null, "fontStyle", model.fontStyle) + SerializeMember(serialized, null, "hover", model.hover) + SerializeMember(serialized, null, "imagePosition", model.imagePosition) + SerializeMember(serialized, null, "margin", model.margin) + SerializeMember(serialized, null, "name", model.name) + SerializeMember(serialized, null, "normal", model.normal) + SerializeMember(serialized, null, "onActive", model.onActive) + SerializeMember(serialized, null, "onFocused", model.onFocused) + SerializeMember(serialized, null, "onHover", model.onHover) + SerializeMember(serialized, null, "onNormal", model.onNormal) + SerializeMember(serialized, null, "overflow", model.overflow) + SerializeMember(serialized, null, "padding", model.padding) + SerializeMember(serialized, null, "richText", model.richText) + SerializeMember(serialized, null, "stretchHeight", model.stretchHeight) + SerializeMember(serialized, null, "stretchWidth", model.stretchWidth) + SerializeMember(serialized, null, "wordWrap", model.wordWrap);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref GUIStyle model)
	{
		fsResult success = fsResult.Success;
		GUIStyleState value = model.active;
		fsResult obj = success + DeserializeMember<GUIStyleState>(data, null, "active", out value);
		model.active = value;
		TextAnchor value2 = model.alignment;
		fsResult obj2 = obj + DeserializeMember<TextAnchor>(data, null, "alignment", out value2);
		model.alignment = value2;
		RectOffset value3 = model.border;
		fsResult obj3 = obj2 + DeserializeMember<RectOffset>(data, null, "border", out value3);
		model.border = value3;
		TextClipping value4 = model.clipping;
		fsResult obj4 = obj3 + DeserializeMember<TextClipping>(data, null, "clipping", out value4);
		model.clipping = value4;
		Vector2 value5 = model.contentOffset;
		fsResult obj5 = obj4 + DeserializeMember<Vector2>(data, null, "contentOffset", out value5);
		model.contentOffset = value5;
		float value6 = model.fixedHeight;
		fsResult obj6 = obj5 + DeserializeMember<float>(data, null, "fixedHeight", out value6);
		model.fixedHeight = value6;
		float value7 = model.fixedWidth;
		fsResult obj7 = obj6 + DeserializeMember<float>(data, null, "fixedWidth", out value7);
		model.fixedWidth = value7;
		GUIStyleState value8 = model.focused;
		fsResult obj8 = obj7 + DeserializeMember<GUIStyleState>(data, null, "focused", out value8);
		model.focused = value8;
		Font value9 = model.font;
		fsResult obj9 = obj8 + DeserializeMember<Font>(data, null, "font", out value9);
		model.font = value9;
		int value10 = model.fontSize;
		fsResult obj10 = obj9 + DeserializeMember<int>(data, null, "fontSize", out value10);
		model.fontSize = value10;
		FontStyle value11 = model.fontStyle;
		fsResult obj11 = obj10 + DeserializeMember<FontStyle>(data, null, "fontStyle", out value11);
		model.fontStyle = value11;
		GUIStyleState value12 = model.hover;
		fsResult obj12 = obj11 + DeserializeMember<GUIStyleState>(data, null, "hover", out value12);
		model.hover = value12;
		ImagePosition value13 = model.imagePosition;
		fsResult obj13 = obj12 + DeserializeMember<ImagePosition>(data, null, "imagePosition", out value13);
		model.imagePosition = value13;
		RectOffset value14 = model.margin;
		fsResult obj14 = obj13 + DeserializeMember<RectOffset>(data, null, "margin", out value14);
		model.margin = value14;
		string value15 = model.name;
		fsResult obj15 = obj14 + DeserializeMember<string>(data, null, "name", out value15);
		model.name = value15;
		GUIStyleState value16 = model.normal;
		fsResult obj16 = obj15 + DeserializeMember<GUIStyleState>(data, null, "normal", out value16);
		model.normal = value16;
		GUIStyleState value17 = model.onActive;
		fsResult obj17 = obj16 + DeserializeMember<GUIStyleState>(data, null, "onActive", out value17);
		model.onActive = value17;
		GUIStyleState value18 = model.onFocused;
		fsResult obj18 = obj17 + DeserializeMember<GUIStyleState>(data, null, "onFocused", out value18);
		model.onFocused = value18;
		GUIStyleState value19 = model.onHover;
		fsResult obj19 = obj18 + DeserializeMember<GUIStyleState>(data, null, "onHover", out value19);
		model.onHover = value19;
		GUIStyleState value20 = model.onNormal;
		fsResult obj20 = obj19 + DeserializeMember<GUIStyleState>(data, null, "onNormal", out value20);
		model.onNormal = value20;
		RectOffset value21 = model.overflow;
		fsResult obj21 = obj20 + DeserializeMember<RectOffset>(data, null, "overflow", out value21);
		model.overflow = value21;
		RectOffset value22 = model.padding;
		fsResult obj22 = obj21 + DeserializeMember<RectOffset>(data, null, "padding", out value22);
		model.padding = value22;
		bool value23 = model.richText;
		fsResult obj23 = obj22 + DeserializeMember<bool>(data, null, "richText", out value23);
		model.richText = value23;
		bool value24 = model.stretchHeight;
		fsResult obj24 = obj23 + DeserializeMember<bool>(data, null, "stretchHeight", out value24);
		model.stretchHeight = value24;
		bool value25 = model.stretchWidth;
		fsResult obj25 = obj24 + DeserializeMember<bool>(data, null, "stretchWidth", out value25);
		model.stretchWidth = value25;
		bool value26 = model.wordWrap;
		fsResult result = obj25 + DeserializeMember<bool>(data, null, "wordWrap", out value26);
		model.wordWrap = value26;
		return result;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return new GUIStyle();
	}
}
