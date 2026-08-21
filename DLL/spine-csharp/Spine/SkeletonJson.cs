using System;
using System.Collections.Generic;
using System.IO;

namespace Spine;

public class SkeletonJson : SkeletonLoader
{
	private class LinkedMesh
	{
		internal string parent;

		internal string skin;

		internal int slotIndex;

		internal MeshAttachment mesh;

		internal bool inheritTimelines;

		public LinkedMesh(MeshAttachment mesh, string skin, int slotIndex, string parent, bool inheritTimelines)
		{
			this.mesh = mesh;
			this.skin = skin;
			this.slotIndex = slotIndex;
			this.parent = parent;
			this.inheritTimelines = inheritTimelines;
		}
	}

	private readonly List<LinkedMesh> linkedMeshes = new List<LinkedMesh>();

	public SkeletonJson(AttachmentLoader attachmentLoader)
		: base(attachmentLoader)
	{
	}

	public SkeletonJson(params Atlas[] atlasArray)
		: base(atlasArray)
	{
	}

	public override SkeletonData ReadSkeletonData(string path)
	{
		using StreamReader reader = new StreamReader(new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read));
		SkeletonData skeletonData = ReadSkeletonData(reader);
		skeletonData.name = Path.GetFileNameWithoutExtension(path);
		return skeletonData;
	}

	public SkeletonData ReadSkeletonData(TextReader reader)
	{
		if (reader == null)
		{
			throw new ArgumentNullException("reader", "reader cannot be null.");
		}
		float num = scale;
		SkeletonData skeletonData = new SkeletonData();
		if (!(Json.Deserialize(reader) is Dictionary<string, object> dictionary))
		{
			throw new Exception("Invalid JSON.");
		}
		if (dictionary.ContainsKey("skeleton"))
		{
			Dictionary<string, object> dictionary2 = (Dictionary<string, object>)dictionary["skeleton"];
			skeletonData.hash = (string)dictionary2["hash"];
			skeletonData.version = (string)dictionary2["spine"];
			skeletonData.x = GetFloat(dictionary2, "x", 0f);
			skeletonData.y = GetFloat(dictionary2, "y", 0f);
			skeletonData.width = GetFloat(dictionary2, "width", 0f);
			skeletonData.height = GetFloat(dictionary2, "height", 0f);
			skeletonData.referenceScale = GetFloat(dictionary2, "referenceScale", 100f) * num;
			skeletonData.fps = GetFloat(dictionary2, "fps", 30f);
			skeletonData.imagesPath = GetString(dictionary2, "images", null);
			skeletonData.audioPath = GetString(dictionary2, "audio", null);
		}
		if (dictionary.ContainsKey("bones"))
		{
			foreach (Dictionary<string, object> item in (List<object>)dictionary["bones"])
			{
				BoneData boneData = null;
				if (item.ContainsKey("parent"))
				{
					boneData = skeletonData.FindBone((string)item["parent"]);
					if (boneData == null)
					{
						throw new Exception("Parent bone not found: " + item["parent"]);
					}
				}
				BoneData boneData2 = new BoneData(skeletonData.Bones.Count, (string)item["name"], boneData);
				boneData2.length = GetFloat(item, "length", 0f) * num;
				boneData2.x = GetFloat(item, "x", 0f) * num;
				boneData2.y = GetFloat(item, "y", 0f) * num;
				boneData2.rotation = GetFloat(item, "rotation", 0f);
				boneData2.scaleX = GetFloat(item, "scaleX", 1f);
				boneData2.scaleY = GetFloat(item, "scaleY", 1f);
				boneData2.shearX = GetFloat(item, "shearX", 0f);
				boneData2.shearY = GetFloat(item, "shearY", 0f);
				string value = GetString(item, "inherit", Inherit.Normal.ToString());
				boneData2.inherit = (Inherit)Enum.Parse(typeof(Inherit), value, ignoreCase: true);
				boneData2.skinRequired = GetBoolean(item, "skin", defaultValue: false);
				skeletonData.bones.Add(boneData2);
			}
		}
		if (dictionary.ContainsKey("slots"))
		{
			foreach (Dictionary<string, object> item2 in (List<object>)dictionary["slots"])
			{
				string name = (string)item2["name"];
				string text = (string)item2["bone"];
				BoneData boneData3 = skeletonData.FindBone(text);
				if (boneData3 == null)
				{
					throw new Exception("Slot bone not found: " + text);
				}
				SlotData slotData = new SlotData(skeletonData.Slots.Count, name, boneData3);
				if (item2.ContainsKey("color"))
				{
					string hexString = (string)item2["color"];
					slotData.r = ToColor(hexString, 0);
					slotData.g = ToColor(hexString, 1);
					slotData.b = ToColor(hexString, 2);
					slotData.a = ToColor(hexString, 3);
				}
				if (item2.ContainsKey("dark"))
				{
					string hexString2 = (string)item2["dark"];
					slotData.r2 = ToColor(hexString2, 0, 6);
					slotData.g2 = ToColor(hexString2, 1, 6);
					slotData.b2 = ToColor(hexString2, 2, 6);
					slotData.hasSecondColor = true;
				}
				slotData.attachmentName = GetString(item2, "attachment", null);
				if (item2.ContainsKey("blend"))
				{
					slotData.blendMode = (BlendMode)Enum.Parse(typeof(BlendMode), (string)item2["blend"], ignoreCase: true);
				}
				else
				{
					slotData.blendMode = BlendMode.Normal;
				}
				skeletonData.slots.Add(slotData);
			}
		}
		if (dictionary.ContainsKey("ik"))
		{
			foreach (Dictionary<string, object> item3 in (List<object>)dictionary["ik"])
			{
				IkConstraintData ikConstraintData = new IkConstraintData((string)item3["name"]);
				ikConstraintData.order = GetInt(item3, "order", 0);
				ikConstraintData.skinRequired = GetBoolean(item3, "skin", defaultValue: false);
				if (item3.ContainsKey("bones"))
				{
					foreach (string item4 in (List<object>)item3["bones"])
					{
						BoneData boneData4 = skeletonData.FindBone(item4);
						if (boneData4 == null)
						{
							throw new Exception("IK bone not found: " + item4);
						}
						ikConstraintData.bones.Add(boneData4);
					}
				}
				string text3 = (string)item3["target"];
				ikConstraintData.target = skeletonData.FindBone(text3);
				if (ikConstraintData.target == null)
				{
					throw new Exception("IK target bone not found: " + text3);
				}
				ikConstraintData.mix = GetFloat(item3, "mix", 1f);
				ikConstraintData.softness = GetFloat(item3, "softness", 0f) * num;
				ikConstraintData.bendDirection = (GetBoolean(item3, "bendPositive", defaultValue: true) ? 1 : (-1));
				ikConstraintData.compress = GetBoolean(item3, "compress", defaultValue: false);
				ikConstraintData.stretch = GetBoolean(item3, "stretch", defaultValue: false);
				ikConstraintData.uniform = GetBoolean(item3, "uniform", defaultValue: false);
				skeletonData.ikConstraints.Add(ikConstraintData);
			}
		}
		if (dictionary.ContainsKey("transform"))
		{
			foreach (Dictionary<string, object> item5 in (List<object>)dictionary["transform"])
			{
				TransformConstraintData transformConstraintData = new TransformConstraintData((string)item5["name"]);
				transformConstraintData.order = GetInt(item5, "order", 0);
				transformConstraintData.skinRequired = GetBoolean(item5, "skin", defaultValue: false);
				if (item5.ContainsKey("bones"))
				{
					foreach (string item6 in (List<object>)item5["bones"])
					{
						BoneData boneData5 = skeletonData.FindBone(item6);
						if (boneData5 == null)
						{
							throw new Exception("Transform constraint bone not found: " + item6);
						}
						transformConstraintData.bones.Add(boneData5);
					}
				}
				string text5 = (string)item5["target"];
				transformConstraintData.target = skeletonData.FindBone(text5);
				if (transformConstraintData.target == null)
				{
					throw new Exception("Transform constraint target bone not found: " + text5);
				}
				transformConstraintData.local = GetBoolean(item5, "local", defaultValue: false);
				transformConstraintData.relative = GetBoolean(item5, "relative", defaultValue: false);
				transformConstraintData.offsetRotation = GetFloat(item5, "rotation", 0f);
				transformConstraintData.offsetX = GetFloat(item5, "x", 0f) * num;
				transformConstraintData.offsetY = GetFloat(item5, "y", 0f) * num;
				transformConstraintData.offsetScaleX = GetFloat(item5, "scaleX", 0f);
				transformConstraintData.offsetScaleY = GetFloat(item5, "scaleY", 0f);
				transformConstraintData.offsetShearY = GetFloat(item5, "shearY", 0f);
				transformConstraintData.mixRotate = GetFloat(item5, "mixRotate", 1f);
				transformConstraintData.mixX = GetFloat(item5, "mixX", 1f);
				transformConstraintData.mixY = GetFloat(item5, "mixY", transformConstraintData.mixX);
				transformConstraintData.mixScaleX = GetFloat(item5, "mixScaleX", 1f);
				transformConstraintData.mixScaleY = GetFloat(item5, "mixScaleY", transformConstraintData.mixScaleX);
				transformConstraintData.mixShearY = GetFloat(item5, "mixShearY", 1f);
				skeletonData.transformConstraints.Add(transformConstraintData);
			}
		}
		if (dictionary.ContainsKey("path"))
		{
			foreach (Dictionary<string, object> item7 in (List<object>)dictionary["path"])
			{
				PathConstraintData pathConstraintData = new PathConstraintData((string)item7["name"]);
				pathConstraintData.order = GetInt(item7, "order", 0);
				pathConstraintData.skinRequired = GetBoolean(item7, "skin", defaultValue: false);
				if (item7.ContainsKey("bones"))
				{
					foreach (string item8 in (List<object>)item7["bones"])
					{
						BoneData boneData6 = skeletonData.FindBone(item8);
						if (boneData6 == null)
						{
							throw new Exception("Path bone not found: " + item8);
						}
						pathConstraintData.bones.Add(boneData6);
					}
				}
				string text7 = (string)item7["target"];
				pathConstraintData.target = skeletonData.FindSlot(text7);
				if (pathConstraintData.target == null)
				{
					throw new Exception("Path target slot not found: " + text7);
				}
				pathConstraintData.positionMode = (PositionMode)Enum.Parse(typeof(PositionMode), GetString(item7, "positionMode", "percent"), ignoreCase: true);
				pathConstraintData.spacingMode = (SpacingMode)Enum.Parse(typeof(SpacingMode), GetString(item7, "spacingMode", "length"), ignoreCase: true);
				pathConstraintData.rotateMode = (RotateMode)Enum.Parse(typeof(RotateMode), GetString(item7, "rotateMode", "tangent"), ignoreCase: true);
				pathConstraintData.offsetRotation = GetFloat(item7, "rotation", 0f);
				pathConstraintData.position = GetFloat(item7, "position", 0f);
				if (pathConstraintData.positionMode == PositionMode.Fixed)
				{
					pathConstraintData.position *= num;
				}
				pathConstraintData.spacing = GetFloat(item7, "spacing", 0f);
				if (pathConstraintData.spacingMode == SpacingMode.Length || pathConstraintData.spacingMode == SpacingMode.Fixed)
				{
					pathConstraintData.spacing *= num;
				}
				pathConstraintData.mixRotate = GetFloat(item7, "mixRotate", 1f);
				pathConstraintData.mixX = GetFloat(item7, "mixX", 1f);
				pathConstraintData.mixY = GetFloat(item7, "mixY", pathConstraintData.mixX);
				skeletonData.pathConstraints.Add(pathConstraintData);
			}
		}
		if (dictionary.ContainsKey("physics"))
		{
			foreach (Dictionary<string, object> item9 in (List<object>)dictionary["physics"])
			{
				PhysicsConstraintData physicsConstraintData = new PhysicsConstraintData((string)item9["name"]);
				physicsConstraintData.order = GetInt(item9, "order", 0);
				physicsConstraintData.skinRequired = GetBoolean(item9, "skin", defaultValue: false);
				string text8 = (string)item9["bone"];
				physicsConstraintData.bone = skeletonData.FindBone(text8);
				if (physicsConstraintData.bone == null)
				{
					throw new Exception("Physics bone not found: " + text8);
				}
				physicsConstraintData.x = GetFloat(item9, "x", 0f);
				physicsConstraintData.y = GetFloat(item9, "y", 0f);
				physicsConstraintData.rotate = GetFloat(item9, "rotate", 0f);
				physicsConstraintData.scaleX = GetFloat(item9, "scaleX", 0f);
				physicsConstraintData.shearX = GetFloat(item9, "shearX", 0f);
				physicsConstraintData.limit = GetFloat(item9, "limit", 5000f) * num;
				physicsConstraintData.step = 1f / (float)GetInt(item9, "fps", 60);
				physicsConstraintData.inertia = GetFloat(item9, "inertia", 1f);
				physicsConstraintData.strength = GetFloat(item9, "strength", 100f);
				physicsConstraintData.damping = GetFloat(item9, "damping", 1f);
				physicsConstraintData.massInverse = 1f / GetFloat(item9, "mass", 1f);
				physicsConstraintData.wind = GetFloat(item9, "wind", 0f);
				physicsConstraintData.gravity = GetFloat(item9, "gravity", 0f);
				physicsConstraintData.mix = GetFloat(item9, "mix", 1f);
				physicsConstraintData.inertiaGlobal = GetBoolean(item9, "inertiaGlobal", defaultValue: false);
				physicsConstraintData.strengthGlobal = GetBoolean(item9, "strengthGlobal", defaultValue: false);
				physicsConstraintData.dampingGlobal = GetBoolean(item9, "dampingGlobal", defaultValue: false);
				physicsConstraintData.massGlobal = GetBoolean(item9, "massGlobal", defaultValue: false);
				physicsConstraintData.windGlobal = GetBoolean(item9, "windGlobal", defaultValue: false);
				physicsConstraintData.gravityGlobal = GetBoolean(item9, "gravityGlobal", defaultValue: false);
				physicsConstraintData.mixGlobal = GetBoolean(item9, "mixGlobal", defaultValue: false);
				skeletonData.physicsConstraints.Add(physicsConstraintData);
			}
		}
		if (dictionary.ContainsKey("skins"))
		{
			foreach (Dictionary<string, object> item10 in (List<object>)dictionary["skins"])
			{
				Skin skin = new Skin((string)item10["name"]);
				if (item10.ContainsKey("bones"))
				{
					foreach (string item11 in (List<object>)item10["bones"])
					{
						BoneData boneData7 = skeletonData.FindBone(item11);
						if (boneData7 == null)
						{
							throw new Exception("Skin bone not found: " + item11);
						}
						skin.bones.Add(boneData7);
					}
				}
				skin.bones.TrimExcess();
				if (item10.ContainsKey("ik"))
				{
					foreach (string item12 in (List<object>)item10["ik"])
					{
						IkConstraintData ikConstraintData2 = skeletonData.FindIkConstraint(item12);
						if (ikConstraintData2 == null)
						{
							throw new Exception("Skin IK constraint not found: " + item12);
						}
						skin.constraints.Add(ikConstraintData2);
					}
				}
				if (item10.ContainsKey("transform"))
				{
					foreach (string item13 in (List<object>)item10["transform"])
					{
						TransformConstraintData transformConstraintData2 = skeletonData.FindTransformConstraint(item13);
						if (transformConstraintData2 == null)
						{
							throw new Exception("Skin transform constraint not found: " + item13);
						}
						skin.constraints.Add(transformConstraintData2);
					}
				}
				if (item10.ContainsKey("path"))
				{
					foreach (string item14 in (List<object>)item10["path"])
					{
						PathConstraintData pathConstraintData2 = skeletonData.FindPathConstraint(item14);
						if (pathConstraintData2 == null)
						{
							throw new Exception("Skin path constraint not found: " + item14);
						}
						skin.constraints.Add(pathConstraintData2);
					}
				}
				if (item10.ContainsKey("physics"))
				{
					foreach (string item15 in (List<object>)item10["physics"])
					{
						PhysicsConstraintData physicsConstraintData2 = skeletonData.FindPhysicsConstraint(item15);
						if (physicsConstraintData2 == null)
						{
							throw new Exception("Skin physics constraint not found: " + item15);
						}
						skin.constraints.Add(physicsConstraintData2);
					}
				}
				skin.constraints.TrimExcess();
				if (item10.ContainsKey("attachments"))
				{
					foreach (KeyValuePair<string, object> item16 in (Dictionary<string, object>)item10["attachments"])
					{
						int slotIndex = FindSlotIndex(skeletonData, item16.Key);
						foreach (KeyValuePair<string, object> item17 in (Dictionary<string, object>)item16.Value)
						{
							try
							{
								Attachment attachment = ReadAttachment((Dictionary<string, object>)item17.Value, skin, slotIndex, item17.Key, skeletonData);
								if (attachment != null)
								{
									skin.SetAttachment(slotIndex, item17.Key, attachment);
								}
							}
							catch (Exception innerException)
							{
								throw new Exception("Error reading attachment: " + item17.Key + ", skin: " + skin, innerException);
							}
						}
					}
				}
				skeletonData.skins.Add(skin);
				if (skin.name == "default")
				{
					skeletonData.defaultSkin = skin;
				}
			}
		}
		int i = 0;
		for (int count = linkedMeshes.Count; i < count; i++)
		{
			LinkedMesh linkedMesh = linkedMeshes[i];
			Attachment attachment2 = (((linkedMesh.skin == null) ? skeletonData.defaultSkin : skeletonData.FindSkin(linkedMesh.skin)) ?? throw new Exception("Slot not found: " + linkedMesh.skin)).GetAttachment(linkedMesh.slotIndex, linkedMesh.parent);
			if (attachment2 == null)
			{
				throw new Exception("Parent mesh not found: " + linkedMesh.parent);
			}
			linkedMesh.mesh.TimelineAttachment = (linkedMesh.inheritTimelines ? ((VertexAttachment)attachment2) : linkedMesh.mesh);
			linkedMesh.mesh.ParentMesh = (MeshAttachment)attachment2;
			if (linkedMesh.mesh.Region != null)
			{
				linkedMesh.mesh.UpdateRegion();
			}
		}
		linkedMeshes.Clear();
		if (dictionary.ContainsKey("events"))
		{
			foreach (KeyValuePair<string, object> item18 in (Dictionary<string, object>)dictionary["events"])
			{
				Dictionary<string, object> map = (Dictionary<string, object>)item18.Value;
				EventData eventData = new EventData(item18.Key);
				eventData.Int = GetInt(map, "int", 0);
				eventData.Float = GetFloat(map, "float", 0f);
				eventData.String = GetString(map, "string", string.Empty);
				eventData.AudioPath = GetString(map, "audio", null);
				if (eventData.AudioPath != null)
				{
					eventData.Volume = GetFloat(map, "volume", 1f);
					eventData.Balance = GetFloat(map, "balance", 0f);
				}
				skeletonData.events.Add(eventData);
			}
		}
		if (dictionary.ContainsKey("animations"))
		{
			foreach (KeyValuePair<string, object> item19 in (Dictionary<string, object>)dictionary["animations"])
			{
				try
				{
					ReadAnimation((Dictionary<string, object>)item19.Value, item19.Key, skeletonData);
				}
				catch (Exception ex)
				{
					throw new Exception("Error reading animation: " + item19.Key + "\n" + ex.Message, ex);
				}
			}
		}
		skeletonData.bones.TrimExcess();
		skeletonData.slots.TrimExcess();
		skeletonData.skins.TrimExcess();
		skeletonData.events.TrimExcess();
		skeletonData.animations.TrimExcess();
		skeletonData.ikConstraints.TrimExcess();
		return skeletonData;
	}

	private Attachment ReadAttachment(Dictionary<string, object> map, Skin skin, int slotIndex, string name, SkeletonData skeletonData)
	{
		float num = scale;
		name = GetString(map, "name", name);
		string value = GetString(map, "type", "region");
		switch ((AttachmentType)Enum.Parse(typeof(AttachmentType), value, ignoreCase: true))
		{
		case AttachmentType.Region:
		{
			string path = GetString(map, "path", name);
			map.TryGetValue("sequence", out var value2);
			Sequence sequence = ReadSequence(value2);
			RegionAttachment regionAttachment = attachmentLoader.NewRegionAttachment(skin, name, path, sequence);
			if (regionAttachment == null)
			{
				return null;
			}
			regionAttachment.Path = path;
			regionAttachment.x = GetFloat(map, "x", 0f) * num;
			regionAttachment.y = GetFloat(map, "y", 0f) * num;
			regionAttachment.scaleX = GetFloat(map, "scaleX", 1f);
			regionAttachment.scaleY = GetFloat(map, "scaleY", 1f);
			regionAttachment.rotation = GetFloat(map, "rotation", 0f);
			regionAttachment.width = GetFloat(map, "width", 32f) * num;
			regionAttachment.height = GetFloat(map, "height", 32f) * num;
			regionAttachment.sequence = sequence;
			if (map.ContainsKey("color"))
			{
				string hexString = (string)map["color"];
				regionAttachment.r = ToColor(hexString, 0);
				regionAttachment.g = ToColor(hexString, 1);
				regionAttachment.b = ToColor(hexString, 2);
				regionAttachment.a = ToColor(hexString, 3);
			}
			if (regionAttachment.Region != null)
			{
				regionAttachment.UpdateRegion();
			}
			return regionAttachment;
		}
		case AttachmentType.Boundingbox:
		{
			BoundingBoxAttachment boundingBoxAttachment = attachmentLoader.NewBoundingBoxAttachment(skin, name);
			if (boundingBoxAttachment == null)
			{
				return null;
			}
			ReadVertices(map, boundingBoxAttachment, GetInt(map, "vertexCount", 0) << 1);
			return boundingBoxAttachment;
		}
		case AttachmentType.Mesh:
		case AttachmentType.Linkedmesh:
		{
			string path2 = GetString(map, "path", name);
			map.TryGetValue("sequence", out var value3);
			Sequence sequence2 = ReadSequence(value3);
			MeshAttachment meshAttachment = attachmentLoader.NewMeshAttachment(skin, name, path2, sequence2);
			if (meshAttachment == null)
			{
				return null;
			}
			meshAttachment.Path = path2;
			if (map.ContainsKey("color"))
			{
				string hexString2 = (string)map["color"];
				meshAttachment.r = ToColor(hexString2, 0);
				meshAttachment.g = ToColor(hexString2, 1);
				meshAttachment.b = ToColor(hexString2, 2);
				meshAttachment.a = ToColor(hexString2, 3);
			}
			meshAttachment.Width = GetFloat(map, "width", 0f) * num;
			meshAttachment.Height = GetFloat(map, "height", 0f) * num;
			meshAttachment.Sequence = sequence2;
			string text2 = GetString(map, "parent", null);
			if (text2 != null)
			{
				linkedMeshes.Add(new LinkedMesh(meshAttachment, GetString(map, "skin", null), slotIndex, text2, GetBoolean(map, "timelines", defaultValue: true)));
				return meshAttachment;
			}
			float[] floatArray = GetFloatArray(map, "uvs", 1f);
			ReadVertices(map, meshAttachment, floatArray.Length);
			meshAttachment.triangles = GetIntArray(map, "triangles");
			meshAttachment.regionUVs = floatArray;
			if (meshAttachment.Region != null)
			{
				meshAttachment.UpdateRegion();
			}
			if (map.ContainsKey("hull"))
			{
				meshAttachment.HullLength = GetInt(map, "hull", 0) << 1;
			}
			if (map.ContainsKey("edges"))
			{
				meshAttachment.Edges = GetIntArray(map, "edges");
			}
			return meshAttachment;
		}
		case AttachmentType.Path:
		{
			PathAttachment pathAttachment = attachmentLoader.NewPathAttachment(skin, name);
			if (pathAttachment == null)
			{
				return null;
			}
			pathAttachment.closed = GetBoolean(map, "closed", defaultValue: false);
			pathAttachment.constantSpeed = GetBoolean(map, "constantSpeed", defaultValue: true);
			int num2 = GetInt(map, "vertexCount", 0);
			ReadVertices(map, pathAttachment, num2 << 1);
			pathAttachment.lengths = GetFloatArray(map, "lengths", num);
			return pathAttachment;
		}
		case AttachmentType.Point:
		{
			PointAttachment pointAttachment = attachmentLoader.NewPointAttachment(skin, name);
			if (pointAttachment == null)
			{
				return null;
			}
			pointAttachment.x = GetFloat(map, "x", 0f) * num;
			pointAttachment.y = GetFloat(map, "y", 0f) * num;
			pointAttachment.rotation = GetFloat(map, "rotation", 0f);
			return pointAttachment;
		}
		case AttachmentType.Clipping:
		{
			ClippingAttachment clippingAttachment = attachmentLoader.NewClippingAttachment(skin, name);
			if (clippingAttachment == null)
			{
				return null;
			}
			string text = GetString(map, "end", null);
			if (text != null)
			{
				SlotData slotData = skeletonData.FindSlot(text);
				if (slotData == null)
				{
					throw new Exception("Clipping end slot not found: " + text);
				}
				clippingAttachment.EndSlot = slotData;
			}
			ReadVertices(map, clippingAttachment, GetInt(map, "vertexCount", 0) << 1);
			return clippingAttachment;
		}
		default:
			return null;
		}
	}

	public static Sequence ReadSequence(object sequenceJson)
	{
		if (!(sequenceJson is Dictionary<string, object> map))
		{
			return null;
		}
		return new Sequence(GetInt(map, "count"))
		{
			start = GetInt(map, "start", 1),
			digits = GetInt(map, "digits", 0),
			setupIndex = GetInt(map, "setup", 0)
		};
	}

	private void ReadVertices(Dictionary<string, object> map, VertexAttachment attachment, int verticesLength)
	{
		attachment.WorldVerticesLength = verticesLength;
		float[] floatArray = GetFloatArray(map, "vertices", 1f);
		float num = base.Scale;
		if (verticesLength == floatArray.Length)
		{
			if (num != 1f)
			{
				for (int i = 0; i < floatArray.Length; i++)
				{
					floatArray[i] *= num;
				}
			}
			attachment.vertices = floatArray;
			return;
		}
		ExposedList<float> exposedList = new ExposedList<float>(verticesLength * 3 * 3);
		ExposedList<int> exposedList2 = new ExposedList<int>(verticesLength * 3);
		int j = 0;
		int num2 = floatArray.Length;
		while (j < num2)
		{
			int num3 = (int)floatArray[j++];
			exposedList2.Add(num3);
			for (int num4 = j + (num3 << 2); j < num4; j += 4)
			{
				exposedList2.Add((int)floatArray[j]);
				exposedList.Add(floatArray[j + 1] * base.Scale);
				exposedList.Add(floatArray[j + 2] * base.Scale);
				exposedList.Add(floatArray[j + 3]);
			}
		}
		attachment.bones = exposedList2.ToArray();
		attachment.vertices = exposedList.ToArray();
	}

	private int FindSlotIndex(SkeletonData skeletonData, string slotName)
	{
		SlotData[] items = skeletonData.slots.Items;
		int i = 0;
		for (int count = skeletonData.slots.Count; i < count; i++)
		{
			if (items[i].name == slotName)
			{
				return i;
			}
		}
		throw new Exception("Slot not found: " + slotName);
	}

	private void ReadAnimation(Dictionary<string, object> map, string name, SkeletonData skeletonData)
	{
		float num = scale;
		ExposedList<Timeline> exposedList = new ExposedList<Timeline>();
		if (map.ContainsKey("slots"))
		{
			foreach (KeyValuePair<string, object> item3 in (Dictionary<string, object>)map["slots"])
			{
				string key = item3.Key;
				int slotIndex = FindSlotIndex(skeletonData, key);
				foreach (KeyValuePair<string, object> item4 in (Dictionary<string, object>)item3.Value)
				{
					List<object> list = (List<object>)item4.Value;
					int count = list.Count;
					if (count == 0)
					{
						continue;
					}
					string key2 = item4.Key;
					switch (key2)
					{
					case "attachment":
					{
						AttachmentTimeline attachmentTimeline = new AttachmentTimeline(count, slotIndex);
						int num58 = 0;
						foreach (Dictionary<string, object> item5 in list)
						{
							attachmentTimeline.SetFrame(num58++, GetFloat(item5, "time", 0f), GetString(item5, "name", null));
						}
						exposedList.Add(attachmentTimeline);
						break;
					}
					case "rgba":
					{
						RGBATimeline rGBATimeline = new RGBATimeline(count, count << 2, slotIndex);
						List<object>.Enumerator enumerator6 = list.GetEnumerator();
						enumerator6.MoveNext();
						Dictionary<string, object> dictionary4 = (Dictionary<string, object>)enumerator6.Current;
						float num46 = GetFloat(dictionary4, "time", 0f);
						string hexString11 = (string)dictionary4["color"];
						float num47 = ToColor(hexString11, 0);
						float num48 = ToColor(hexString11, 1);
						float num49 = ToColor(hexString11, 2);
						float num50 = ToColor(hexString11, 3);
						int num51 = 0;
						int num52 = 0;
						while (true)
						{
							rGBATimeline.SetFrame(num51, num46, num47, num48, num49, num50);
							if (!enumerator6.MoveNext())
							{
								break;
							}
							Dictionary<string, object> obj4 = (Dictionary<string, object>)enumerator6.Current;
							float num53 = GetFloat(obj4, "time", 0f);
							string hexString12 = (string)obj4["color"];
							float num54 = ToColor(hexString12, 0);
							float num55 = ToColor(hexString12, 1);
							float num56 = ToColor(hexString12, 2);
							float num57 = ToColor(hexString12, 3);
							if (dictionary4.ContainsKey("curve"))
							{
								object curve4 = dictionary4["curve"];
								num52 = ReadCurve(curve4, rGBATimeline, num52, num51, 0, num46, num53, num47, num54, 1f);
								num52 = ReadCurve(curve4, rGBATimeline, num52, num51, 1, num46, num53, num48, num55, 1f);
								num52 = ReadCurve(curve4, rGBATimeline, num52, num51, 2, num46, num53, num49, num56, 1f);
								num52 = ReadCurve(curve4, rGBATimeline, num52, num51, 3, num46, num53, num50, num57, 1f);
							}
							num46 = num53;
							num47 = num54;
							num48 = num55;
							num49 = num56;
							num50 = num57;
							dictionary4 = obj4;
							num51++;
						}
						rGBATimeline.Shrink(num52);
						exposedList.Add(rGBATimeline);
						break;
					}
					case "rgb":
					{
						RGBTimeline rGBTimeline = new RGBTimeline(count, count * 3, slotIndex);
						List<object>.Enumerator enumerator4 = list.GetEnumerator();
						enumerator4.MoveNext();
						Dictionary<string, object> dictionary2 = (Dictionary<string, object>)enumerator4.Current;
						float num18 = GetFloat(dictionary2, "time", 0f);
						string hexString5 = (string)dictionary2["color"];
						float num19 = ToColor(hexString5, 0, 6);
						float num20 = ToColor(hexString5, 1, 6);
						float num21 = ToColor(hexString5, 2, 6);
						int num22 = 0;
						int num23 = 0;
						while (true)
						{
							rGBTimeline.SetFrame(num22, num18, num19, num20, num21);
							if (!enumerator4.MoveNext())
							{
								break;
							}
							Dictionary<string, object> obj2 = (Dictionary<string, object>)enumerator4.Current;
							float num24 = GetFloat(obj2, "time", 0f);
							string hexString6 = (string)obj2["color"];
							float num25 = ToColor(hexString6, 0, 6);
							float num26 = ToColor(hexString6, 1, 6);
							float num27 = ToColor(hexString6, 2, 6);
							if (dictionary2.ContainsKey("curve"))
							{
								object curve2 = dictionary2["curve"];
								num23 = ReadCurve(curve2, rGBTimeline, num23, num22, 0, num18, num24, num19, num25, 1f);
								num23 = ReadCurve(curve2, rGBTimeline, num23, num22, 1, num18, num24, num20, num26, 1f);
								num23 = ReadCurve(curve2, rGBTimeline, num23, num22, 2, num18, num24, num21, num27, 1f);
							}
							num18 = num24;
							num19 = num25;
							num20 = num26;
							num21 = num27;
							dictionary2 = obj2;
							num22++;
						}
						rGBTimeline.Shrink(num23);
						exposedList.Add(rGBTimeline);
						break;
					}
					case "alpha":
					{
						List<object>.Enumerator keyMapEnumerator = list.GetEnumerator();
						keyMapEnumerator.MoveNext();
						exposedList.Add(ReadTimeline(ref keyMapEnumerator, new AlphaTimeline(count, count, slotIndex), 0f, 1f));
						break;
					}
					case "rgba2":
					{
						RGBA2Timeline rGBA2Timeline = new RGBA2Timeline(count, count * 7, slotIndex);
						List<object>.Enumerator enumerator5 = list.GetEnumerator();
						enumerator5.MoveNext();
						Dictionary<string, object> dictionary3 = (Dictionary<string, object>)enumerator5.Current;
						float num28 = GetFloat(dictionary3, "time", 0f);
						string hexString7 = (string)dictionary3["light"];
						float num29 = ToColor(hexString7, 0);
						float num30 = ToColor(hexString7, 1);
						float num31 = ToColor(hexString7, 2);
						float num32 = ToColor(hexString7, 3);
						string hexString8 = (string)dictionary3["dark"];
						float num33 = ToColor(hexString8, 0, 6);
						float num34 = ToColor(hexString8, 1, 6);
						float num35 = ToColor(hexString8, 2, 6);
						int num36 = 0;
						int num37 = 0;
						while (true)
						{
							rGBA2Timeline.SetFrame(num36, num28, num29, num30, num31, num32, num33, num34, num35);
							if (!enumerator5.MoveNext())
							{
								break;
							}
							Dictionary<string, object> obj3 = (Dictionary<string, object>)enumerator5.Current;
							float num38 = GetFloat(obj3, "time", 0f);
							string hexString9 = (string)obj3["light"];
							float num39 = ToColor(hexString9, 0);
							float num40 = ToColor(hexString9, 1);
							float num41 = ToColor(hexString9, 2);
							float num42 = ToColor(hexString9, 3);
							string hexString10 = (string)obj3["dark"];
							float num43 = ToColor(hexString10, 0, 6);
							float num44 = ToColor(hexString10, 1, 6);
							float num45 = ToColor(hexString10, 2, 6);
							if (dictionary3.ContainsKey("curve"))
							{
								object curve3 = dictionary3["curve"];
								num37 = ReadCurve(curve3, rGBA2Timeline, num37, num36, 0, num28, num38, num29, num39, 1f);
								num37 = ReadCurve(curve3, rGBA2Timeline, num37, num36, 1, num28, num38, num30, num40, 1f);
								num37 = ReadCurve(curve3, rGBA2Timeline, num37, num36, 2, num28, num38, num31, num41, 1f);
								num37 = ReadCurve(curve3, rGBA2Timeline, num37, num36, 3, num28, num38, num32, num42, 1f);
								num37 = ReadCurve(curve3, rGBA2Timeline, num37, num36, 4, num28, num38, num33, num43, 1f);
								num37 = ReadCurve(curve3, rGBA2Timeline, num37, num36, 5, num28, num38, num34, num44, 1f);
								num37 = ReadCurve(curve3, rGBA2Timeline, num37, num36, 6, num28, num38, num35, num45, 1f);
							}
							num28 = num38;
							num29 = num39;
							num30 = num40;
							num31 = num41;
							num32 = num42;
							num33 = num43;
							num34 = num44;
							num35 = num45;
							dictionary3 = obj3;
							num36++;
						}
						rGBA2Timeline.Shrink(num37);
						exposedList.Add(rGBA2Timeline);
						break;
					}
					case "rgb2":
					{
						RGB2Timeline rGB2Timeline = new RGB2Timeline(count, count * 6, slotIndex);
						List<object>.Enumerator enumerator3 = list.GetEnumerator();
						enumerator3.MoveNext();
						Dictionary<string, object> dictionary = (Dictionary<string, object>)enumerator3.Current;
						float num2 = GetFloat(dictionary, "time", 0f);
						string hexString = (string)dictionary["light"];
						float num3 = ToColor(hexString, 0, 6);
						float num4 = ToColor(hexString, 1, 6);
						float num5 = ToColor(hexString, 2, 6);
						string hexString2 = (string)dictionary["dark"];
						float num6 = ToColor(hexString2, 0, 6);
						float num7 = ToColor(hexString2, 1, 6);
						float num8 = ToColor(hexString2, 2, 6);
						int num9 = 0;
						int num10 = 0;
						while (true)
						{
							rGB2Timeline.SetFrame(num9, num2, num3, num4, num5, num6, num7, num8);
							if (!enumerator3.MoveNext())
							{
								break;
							}
							Dictionary<string, object> obj = (Dictionary<string, object>)enumerator3.Current;
							float num11 = GetFloat(obj, "time", 0f);
							string hexString3 = (string)obj["light"];
							float num12 = ToColor(hexString3, 0, 6);
							float num13 = ToColor(hexString3, 1, 6);
							float num14 = ToColor(hexString3, 2, 6);
							string hexString4 = (string)obj["dark"];
							float num15 = ToColor(hexString4, 0, 6);
							float num16 = ToColor(hexString4, 1, 6);
							float num17 = ToColor(hexString4, 2, 6);
							if (dictionary.ContainsKey("curve"))
							{
								object curve = dictionary["curve"];
								num10 = ReadCurve(curve, rGB2Timeline, num10, num9, 0, num2, num11, num3, num12, 1f);
								num10 = ReadCurve(curve, rGB2Timeline, num10, num9, 1, num2, num11, num4, num13, 1f);
								num10 = ReadCurve(curve, rGB2Timeline, num10, num9, 2, num2, num11, num5, num14, 1f);
								num10 = ReadCurve(curve, rGB2Timeline, num10, num9, 3, num2, num11, num6, num15, 1f);
								num10 = ReadCurve(curve, rGB2Timeline, num10, num9, 4, num2, num11, num7, num16, 1f);
								num10 = ReadCurve(curve, rGB2Timeline, num10, num9, 5, num2, num11, num8, num17, 1f);
							}
							num2 = num11;
							num3 = num12;
							num4 = num13;
							num5 = num14;
							num6 = num15;
							num7 = num16;
							num8 = num17;
							dictionary = obj;
							num9++;
						}
						rGB2Timeline.Shrink(num10);
						exposedList.Add(rGB2Timeline);
						break;
					}
					default:
						throw new Exception("Invalid timeline type for a slot: " + key2 + " (" + key + ")");
					}
				}
			}
		}
		if (map.ContainsKey("bones"))
		{
			foreach (KeyValuePair<string, object> item6 in (Dictionary<string, object>)map["bones"])
			{
				string key3 = item6.Key;
				int num59 = -1;
				BoneData[] items = skeletonData.bones.Items;
				int i = 0;
				for (int count2 = skeletonData.bones.Count; i < count2; i++)
				{
					if (items[i].name == key3)
					{
						num59 = i;
						break;
					}
				}
				if (num59 == -1)
				{
					throw new Exception("Bone not found: " + key3);
				}
				foreach (KeyValuePair<string, object> item7 in (Dictionary<string, object>)item6.Value)
				{
					List<object> list2 = (List<object>)item7.Value;
					List<object>.Enumerator keyMapEnumerator2 = list2.GetEnumerator();
					if (!keyMapEnumerator2.MoveNext())
					{
						continue;
					}
					int count3 = list2.Count;
					string key4 = item7.Key;
					switch (key4)
					{
					case "rotate":
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, new RotateTimeline(count3, count3, num59), 0f, 1f));
						break;
					case "translate":
					{
						TranslateTimeline timeline = new TranslateTimeline(count3, count3 << 1, num59);
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, timeline, "x", "y", 0f, num));
						break;
					}
					case "translatex":
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, new TranslateXTimeline(count3, count3, num59), 0f, num));
						break;
					case "translatey":
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, new TranslateYTimeline(count3, count3, num59), 0f, num));
						break;
					case "scale":
					{
						ScaleTimeline timeline3 = new ScaleTimeline(count3, count3 << 1, num59);
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, timeline3, "x", "y", 1f, 1f));
						break;
					}
					case "scalex":
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, new ScaleXTimeline(count3, count3, num59), 1f, 1f));
						break;
					case "scaley":
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, new ScaleYTimeline(count3, count3, num59), 1f, 1f));
						break;
					case "shear":
					{
						ShearTimeline timeline2 = new ShearTimeline(count3, count3 << 1, num59);
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, timeline2, "x", "y", 0f, 1f));
						break;
					}
					case "shearx":
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, new ShearXTimeline(count3, count3, num59), 0f, 1f));
						break;
					case "sheary":
						exposedList.Add(ReadTimeline(ref keyMapEnumerator2, new ShearYTimeline(count3, count3, num59), 0f, 1f));
						break;
					case "inherit":
					{
						InheritTimeline inheritTimeline = new InheritTimeline(count3, num59);
						int num60 = 0;
						while (true)
						{
							Dictionary<string, object> map3 = (Dictionary<string, object>)keyMapEnumerator2.Current;
							float time = GetFloat(map3, "time", 0f);
							Inherit inherit = (Inherit)Enum.Parse(typeof(Inherit), GetString(map3, "inherit", Inherit.Normal.ToString()), ignoreCase: true);
							inheritTimeline.SetFrame(num60, time, inherit);
							if (!keyMapEnumerator2.MoveNext())
							{
								break;
							}
							num60++;
						}
						exposedList.Add(inheritTimeline);
						break;
					}
					default:
						throw new Exception("Invalid timeline type for a bone: " + key4 + " (" + key3 + ")");
					}
				}
			}
		}
		if (map.ContainsKey("ik"))
		{
			foreach (KeyValuePair<string, object> item8 in (Dictionary<string, object>)map["ik"])
			{
				List<object> list3 = (List<object>)item8.Value;
				List<object>.Enumerator enumerator8 = list3.GetEnumerator();
				if (!enumerator8.MoveNext())
				{
					continue;
				}
				Dictionary<string, object> dictionary5 = (Dictionary<string, object>)enumerator8.Current;
				IkConstraintData item = skeletonData.FindIkConstraint(item8.Key);
				IkConstraintTimeline ikConstraintTimeline = new IkConstraintTimeline(list3.Count, list3.Count << 1, skeletonData.IkConstraints.IndexOf(item));
				float num61 = GetFloat(dictionary5, "time", 0f);
				float num62 = GetFloat(dictionary5, "mix", 1f);
				float num63 = GetFloat(dictionary5, "softness", 0f) * num;
				int num64 = 0;
				int num65 = 0;
				while (true)
				{
					ikConstraintTimeline.SetFrame(num64, num61, num62, num63, GetBoolean(dictionary5, "bendPositive", defaultValue: true) ? 1 : (-1), GetBoolean(dictionary5, "compress", defaultValue: false), GetBoolean(dictionary5, "stretch", defaultValue: false));
					if (!enumerator8.MoveNext())
					{
						break;
					}
					Dictionary<string, object> obj5 = (Dictionary<string, object>)enumerator8.Current;
					float num66 = GetFloat(obj5, "time", 0f);
					float num67 = GetFloat(obj5, "mix", 1f);
					float num68 = GetFloat(obj5, "softness", 0f) * num;
					if (dictionary5.ContainsKey("curve"))
					{
						object curve5 = dictionary5["curve"];
						num65 = ReadCurve(curve5, ikConstraintTimeline, num65, num64, 0, num61, num66, num62, num67, 1f);
						num65 = ReadCurve(curve5, ikConstraintTimeline, num65, num64, 1, num61, num66, num63, num68, num);
					}
					num61 = num66;
					num62 = num67;
					num63 = num68;
					dictionary5 = obj5;
					num64++;
				}
				ikConstraintTimeline.Shrink(num65);
				exposedList.Add(ikConstraintTimeline);
			}
		}
		if (map.ContainsKey("transform"))
		{
			foreach (KeyValuePair<string, object> item9 in (Dictionary<string, object>)map["transform"])
			{
				List<object> list4 = (List<object>)item9.Value;
				List<object>.Enumerator enumerator9 = list4.GetEnumerator();
				if (!enumerator9.MoveNext())
				{
					continue;
				}
				Dictionary<string, object> dictionary6 = (Dictionary<string, object>)enumerator9.Current;
				TransformConstraintData item2 = skeletonData.FindTransformConstraint(item9.Key);
				TransformConstraintTimeline transformConstraintTimeline = new TransformConstraintTimeline(list4.Count, list4.Count * 6, skeletonData.TransformConstraints.IndexOf(item2));
				float num69 = GetFloat(dictionary6, "time", 0f);
				float num70 = GetFloat(dictionary6, "mixRotate", 1f);
				float num71 = GetFloat(dictionary6, "mixShearY", 1f);
				float num72 = GetFloat(dictionary6, "mixX", 1f);
				float num73 = GetFloat(dictionary6, "mixY", num72);
				float num74 = GetFloat(dictionary6, "mixScaleX", 1f);
				float num75 = GetFloat(dictionary6, "mixScaleY", num74);
				int num76 = 0;
				int num77 = 0;
				while (true)
				{
					transformConstraintTimeline.SetFrame(num76, num69, num70, num72, num73, num74, num75, num71);
					if (!enumerator9.MoveNext())
					{
						break;
					}
					Dictionary<string, object> obj6 = (Dictionary<string, object>)enumerator9.Current;
					float num78 = GetFloat(obj6, "time", 0f);
					float num79 = GetFloat(obj6, "mixRotate", 1f);
					float num80 = GetFloat(obj6, "mixShearY", 1f);
					float num81 = GetFloat(obj6, "mixX", 1f);
					float num82 = GetFloat(obj6, "mixY", num81);
					float num83 = GetFloat(obj6, "mixScaleX", 1f);
					float num84 = GetFloat(obj6, "mixScaleY", num83);
					if (dictionary6.ContainsKey("curve"))
					{
						object curve6 = dictionary6["curve"];
						num77 = ReadCurve(curve6, transformConstraintTimeline, num77, num76, 0, num69, num78, num70, num79, 1f);
						num77 = ReadCurve(curve6, transformConstraintTimeline, num77, num76, 1, num69, num78, num72, num81, 1f);
						num77 = ReadCurve(curve6, transformConstraintTimeline, num77, num76, 2, num69, num78, num73, num82, 1f);
						num77 = ReadCurve(curve6, transformConstraintTimeline, num77, num76, 3, num69, num78, num74, num83, 1f);
						num77 = ReadCurve(curve6, transformConstraintTimeline, num77, num76, 4, num69, num78, num75, num84, 1f);
						num77 = ReadCurve(curve6, transformConstraintTimeline, num77, num76, 5, num69, num78, num71, num80, 1f);
					}
					num69 = num78;
					num70 = num79;
					num72 = num81;
					num73 = num82;
					num74 = num83;
					num75 = num84;
					num71 = num80;
					dictionary6 = obj6;
					num76++;
				}
				transformConstraintTimeline.Shrink(num77);
				exposedList.Add(transformConstraintTimeline);
			}
		}
		if (map.ContainsKey("path"))
		{
			foreach (KeyValuePair<string, object> item10 in (Dictionary<string, object>)map["path"])
			{
				PathConstraintData pathConstraintData = skeletonData.FindPathConstraint(item10.Key);
				if (pathConstraintData == null)
				{
					throw new Exception("Path constraint not found: " + item10.Key);
				}
				int pathConstraintIndex = skeletonData.pathConstraints.IndexOf(pathConstraintData);
				foreach (KeyValuePair<string, object> item11 in (Dictionary<string, object>)item10.Value)
				{
					List<object> list5 = (List<object>)item11.Value;
					List<object>.Enumerator keyMapEnumerator3 = list5.GetEnumerator();
					if (!keyMapEnumerator3.MoveNext())
					{
						continue;
					}
					int count4 = list5.Count;
					switch (item11.Key)
					{
					case "position":
					{
						CurveTimeline1 timeline5 = new PathConstraintPositionTimeline(count4, count4, pathConstraintIndex);
						exposedList.Add(ReadTimeline(ref keyMapEnumerator3, timeline5, 0f, (pathConstraintData.positionMode == PositionMode.Fixed) ? num : 1f));
						break;
					}
					case "spacing":
					{
						CurveTimeline1 timeline4 = new PathConstraintSpacingTimeline(count4, count4, pathConstraintIndex);
						exposedList.Add(ReadTimeline(ref keyMapEnumerator3, timeline4, 0f, (pathConstraintData.spacingMode == SpacingMode.Length || pathConstraintData.spacingMode == SpacingMode.Fixed) ? num : 1f));
						break;
					}
					case "mix":
					{
						PathConstraintMixTimeline pathConstraintMixTimeline = new PathConstraintMixTimeline(count4, count4 * 3, pathConstraintIndex);
						Dictionary<string, object> dictionary7 = (Dictionary<string, object>)keyMapEnumerator3.Current;
						float num85 = GetFloat(dictionary7, "time", 0f);
						float num86 = GetFloat(dictionary7, "mixRotate", 1f);
						float num87 = GetFloat(dictionary7, "mixX", 1f);
						float num88 = GetFloat(dictionary7, "mixY", num87);
						int num89 = 0;
						int num90 = 0;
						while (true)
						{
							pathConstraintMixTimeline.SetFrame(num89, num85, num86, num87, num88);
							if (!keyMapEnumerator3.MoveNext())
							{
								break;
							}
							Dictionary<string, object> obj7 = (Dictionary<string, object>)keyMapEnumerator3.Current;
							float num91 = GetFloat(obj7, "time", 0f);
							float num92 = GetFloat(obj7, "mixRotate", 1f);
							float num93 = GetFloat(obj7, "mixX", 1f);
							float num94 = GetFloat(obj7, "mixY", num93);
							if (dictionary7.ContainsKey("curve"))
							{
								object curve7 = dictionary7["curve"];
								num90 = ReadCurve(curve7, pathConstraintMixTimeline, num90, num89, 0, num85, num91, num86, num92, 1f);
								num90 = ReadCurve(curve7, pathConstraintMixTimeline, num90, num89, 1, num85, num91, num87, num93, 1f);
								num90 = ReadCurve(curve7, pathConstraintMixTimeline, num90, num89, 2, num85, num91, num88, num94, 1f);
							}
							num85 = num91;
							num86 = num92;
							num87 = num93;
							num88 = num94;
							dictionary7 = obj7;
							num89++;
						}
						pathConstraintMixTimeline.Shrink(num90);
						exposedList.Add(pathConstraintMixTimeline);
						break;
					}
					}
				}
			}
		}
		if (map.ContainsKey("physics"))
		{
			foreach (KeyValuePair<string, object> item12 in (Dictionary<string, object>)map["physics"])
			{
				int physicsConstraintIndex = -1;
				if (!string.IsNullOrEmpty(item12.Key))
				{
					PhysicsConstraintData physicsConstraintData = skeletonData.FindPhysicsConstraint(item12.Key);
					if (physicsConstraintData == null)
					{
						throw new Exception("Physics constraint not found: " + item12.Key);
					}
					physicsConstraintIndex = skeletonData.physicsConstraints.IndexOf(physicsConstraintData);
				}
				foreach (KeyValuePair<string, object> item13 in (Dictionary<string, object>)item12.Value)
				{
					List<object> list6 = (List<object>)item13.Value;
					List<object>.Enumerator keyMapEnumerator4 = list6.GetEnumerator();
					if (!keyMapEnumerator4.MoveNext())
					{
						continue;
					}
					int count5 = list6.Count;
					CurveTimeline1 timeline6;
					switch (item13.Key)
					{
					case "reset":
					{
						PhysicsConstraintResetTimeline physicsConstraintResetTimeline = new PhysicsConstraintResetTimeline(count5, physicsConstraintIndex);
						int num95 = 0;
						foreach (Dictionary<string, object> item14 in list6)
						{
							physicsConstraintResetTimeline.SetFrame(num95++, GetFloat(item14, "time", 0f));
						}
						exposedList.Add(physicsConstraintResetTimeline);
						continue;
					}
					case "inertia":
						timeline6 = new PhysicsConstraintInertiaTimeline(count5, count5, physicsConstraintIndex);
						break;
					case "strength":
						timeline6 = new PhysicsConstraintStrengthTimeline(count5, count5, physicsConstraintIndex);
						break;
					case "damping":
						timeline6 = new PhysicsConstraintDampingTimeline(count5, count5, physicsConstraintIndex);
						break;
					case "mass":
						timeline6 = new PhysicsConstraintMassTimeline(count5, count5, physicsConstraintIndex);
						break;
					case "wind":
						timeline6 = new PhysicsConstraintWindTimeline(count5, count5, physicsConstraintIndex);
						break;
					case "gravity":
						timeline6 = new PhysicsConstraintGravityTimeline(count5, count5, physicsConstraintIndex);
						break;
					case "mix":
						timeline6 = new PhysicsConstraintMixTimeline(count5, count5, physicsConstraintIndex);
						break;
					default:
						continue;
					}
					exposedList.Add(ReadTimeline(ref keyMapEnumerator4, timeline6, 0f, 1f));
				}
			}
		}
		if (map.ContainsKey("attachments"))
		{
			foreach (KeyValuePair<string, object> item15 in (Dictionary<string, object>)map["attachments"])
			{
				Skin skin = skeletonData.FindSkin(item15.Key);
				foreach (KeyValuePair<string, object> item16 in (Dictionary<string, object>)item15.Value)
				{
					SlotData slotData = skeletonData.FindSlot(item16.Key);
					if (slotData == null)
					{
						throw new Exception("Slot not found: " + item16.Key);
					}
					foreach (KeyValuePair<string, object> item17 in (Dictionary<string, object>)item16.Value)
					{
						Attachment attachment = skin.GetAttachment(slotData.index, item17.Key);
						if (attachment == null)
						{
							throw new Exception("Timeline attachment not found: " + item17.Key);
						}
						foreach (KeyValuePair<string, object> item18 in (Dictionary<string, object>)item17.Value)
						{
							List<object> list7 = (List<object>)item18.Value;
							List<object>.Enumerator enumerator12 = list7.GetEnumerator();
							if (!enumerator12.MoveNext())
							{
								continue;
							}
							Dictionary<string, object> dictionary8 = (Dictionary<string, object>)enumerator12.Current;
							int count6 = list7.Count;
							string key5 = item18.Key;
							if (key5 == "deform")
							{
								VertexAttachment vertexAttachment = (VertexAttachment)attachment;
								bool flag = vertexAttachment.bones != null;
								float[] vertices = vertexAttachment.vertices;
								int num96 = (flag ? (vertices.Length / 3 << 1) : vertices.Length);
								DeformTimeline deformTimeline = new DeformTimeline(count6, count6, slotData.Index, vertexAttachment);
								float num97 = GetFloat(dictionary8, "time", 0f);
								int num98 = 0;
								int num99 = 0;
								while (true)
								{
									float[] array;
									if (!dictionary8.ContainsKey("vertices"))
									{
										array = (flag ? new float[num96] : vertices);
									}
									else
									{
										array = new float[num96];
										int num100 = GetInt(dictionary8, "offset", 0);
										float[] floatArray = GetFloatArray(dictionary8, "vertices", 1f);
										Array.Copy(floatArray, 0, array, num100, floatArray.Length);
										if (num != 1f)
										{
											int j = num100;
											for (int num101 = j + floatArray.Length; j < num101; j++)
											{
												array[j] *= num;
											}
										}
										if (!flag)
										{
											for (int k = 0; k < num96; k++)
											{
												array[k] += vertices[k];
											}
										}
									}
									deformTimeline.SetFrame(num98, num97, array);
									if (!enumerator12.MoveNext())
									{
										break;
									}
									Dictionary<string, object> obj8 = (Dictionary<string, object>)enumerator12.Current;
									float num102 = GetFloat(obj8, "time", 0f);
									if (dictionary8.ContainsKey("curve"))
									{
										num99 = ReadCurve(dictionary8["curve"], deformTimeline, num99, num98, 0, num97, num102, 0f, 1f, 1f);
									}
									num97 = num102;
									dictionary8 = obj8;
									num98++;
								}
								deformTimeline.Shrink(num99);
								exposedList.Add(deformTimeline);
							}
							else if (key5 == "sequence")
							{
								SequenceTimeline sequenceTimeline = new SequenceTimeline(count6, slotData.index, attachment);
								float defaultValue = 0f;
								int num103 = 0;
								while (dictionary8 != null)
								{
									float num104 = GetFloat(dictionary8, "delay", defaultValue);
									SequenceMode mode = (SequenceMode)Enum.Parse(typeof(SequenceMode), GetString(dictionary8, "mode", "hold"), ignoreCase: true);
									sequenceTimeline.SetFrame(num103, GetFloat(dictionary8, "time", 0f), mode, GetInt(dictionary8, "index", 0), num104);
									defaultValue = num104;
									dictionary8 = (enumerator12.MoveNext() ? ((Dictionary<string, object>)enumerator12.Current) : null);
									num103++;
								}
								exposedList.Add(sequenceTimeline);
							}
						}
					}
				}
			}
		}
		if (map.ContainsKey("drawOrder"))
		{
			List<object> obj9 = (List<object>)map["drawOrder"];
			DrawOrderTimeline drawOrderTimeline = new DrawOrderTimeline(obj9.Count);
			int count7 = skeletonData.slots.Count;
			int num105 = 0;
			foreach (Dictionary<string, object> item19 in obj9)
			{
				int[] array2 = null;
				if (item19.ContainsKey("offsets"))
				{
					array2 = new int[count7];
					for (int num106 = count7 - 1; num106 >= 0; num106--)
					{
						array2[num106] = -1;
					}
					List<object> list8 = (List<object>)item19["offsets"];
					int[] array3 = new int[count7 - list8.Count];
					int num107 = 0;
					int num108 = 0;
					foreach (Dictionary<string, object> item20 in list8)
					{
						int num109 = FindSlotIndex(skeletonData, (string)item20["slot"]);
						while (num107 != num109)
						{
							array3[num108++] = num107++;
						}
						int num110 = num107 + (int)(float)item20["offset"];
						array2[num110] = num107++;
					}
					while (num107 < count7)
					{
						array3[num108++] = num107++;
					}
					for (int num111 = count7 - 1; num111 >= 0; num111--)
					{
						if (array2[num111] == -1)
						{
							array2[num111] = array3[--num108];
						}
					}
				}
				drawOrderTimeline.SetFrame(num105, GetFloat(item19, "time", 0f), array2);
				num105++;
			}
			exposedList.Add(drawOrderTimeline);
		}
		if (map.ContainsKey("events"))
		{
			List<object> obj10 = (List<object>)map["events"];
			EventTimeline eventTimeline = new EventTimeline(obj10.Count);
			int num112 = 0;
			foreach (Dictionary<string, object> item21 in obj10)
			{
				EventData eventData = skeletonData.FindEvent((string)item21["name"]);
				if (eventData == null)
				{
					throw new Exception("Event not found: " + item21["name"]);
				}
				Event obj11 = new Event(GetFloat(item21, "time", 0f), eventData)
				{
					intValue = GetInt(item21, "int", eventData.Int),
					floatValue = GetFloat(item21, "float", eventData.Float),
					stringValue = GetString(item21, "string", eventData.String)
				};
				if (obj11.data.AudioPath != null)
				{
					obj11.volume = GetFloat(item21, "volume", eventData.Volume);
					obj11.balance = GetFloat(item21, "balance", eventData.Balance);
				}
				eventTimeline.SetFrame(num112, obj11);
				num112++;
			}
			exposedList.Add(eventTimeline);
		}
		exposedList.TrimExcess();
		float num113 = 0f;
		Timeline[] items2 = exposedList.Items;
		int l = 0;
		for (int count8 = exposedList.Count; l < count8; l++)
		{
			num113 = Math.Max(num113, items2[l].Duration);
		}
		skeletonData.animations.Add(new Animation(name, exposedList, num113));
	}

	private static Timeline ReadTimeline(ref List<object>.Enumerator keyMapEnumerator, CurveTimeline1 timeline, float defaultValue, float scale)
	{
		Dictionary<string, object> dictionary = (Dictionary<string, object>)keyMapEnumerator.Current;
		float num = GetFloat(dictionary, "time", 0f);
		float num2 = GetFloat(dictionary, "value", defaultValue) * scale;
		int num3 = 0;
		int num4 = 0;
		while (true)
		{
			timeline.SetFrame(num3, num, num2);
			if (!keyMapEnumerator.MoveNext())
			{
				break;
			}
			Dictionary<string, object> obj = (Dictionary<string, object>)keyMapEnumerator.Current;
			float num5 = GetFloat(obj, "time", 0f);
			float num6 = GetFloat(obj, "value", defaultValue) * scale;
			if (dictionary.ContainsKey("curve"))
			{
				num4 = ReadCurve(dictionary["curve"], timeline, num4, num3, 0, num, num5, num2, num6, scale);
			}
			num = num5;
			num2 = num6;
			dictionary = obj;
			num3++;
		}
		timeline.Shrink(num4);
		return timeline;
	}

	private static Timeline ReadTimeline(ref List<object>.Enumerator keyMapEnumerator, CurveTimeline2 timeline, string name1, string name2, float defaultValue, float scale)
	{
		Dictionary<string, object> dictionary = (Dictionary<string, object>)keyMapEnumerator.Current;
		float num = GetFloat(dictionary, "time", 0f);
		float value = GetFloat(dictionary, name1, defaultValue) * scale;
		float num2 = GetFloat(dictionary, name2, defaultValue) * scale;
		int num3 = 0;
		int num4 = 0;
		while (true)
		{
			timeline.SetFrame(num3, num, value, num2);
			if (!keyMapEnumerator.MoveNext())
			{
				break;
			}
			Dictionary<string, object> obj = (Dictionary<string, object>)keyMapEnumerator.Current;
			float num5 = GetFloat(obj, "time", 0f);
			float num6 = GetFloat(obj, name1, defaultValue) * scale;
			float num7 = GetFloat(obj, name2, defaultValue) * scale;
			if (dictionary.ContainsKey("curve"))
			{
				object curve = dictionary["curve"];
				num4 = ReadCurve(curve, timeline, num4, num3, 0, num, num5, value, num6, scale);
				num4 = ReadCurve(curve, timeline, num4, num3, 1, num, num5, num2, num7, scale);
			}
			num = num5;
			value = num6;
			num2 = num7;
			dictionary = obj;
			num3++;
		}
		timeline.Shrink(num4);
		return timeline;
	}

	private static int ReadCurve(object curve, CurveTimeline timeline, int bezier, int frame, int value, float time1, float time2, float value1, float value2, float scale)
	{
		if (curve is string text)
		{
			if (text == "stepped")
			{
				timeline.SetStepped(frame);
			}
			return bezier;
		}
		List<object> obj = (List<object>)curve;
		int num = value << 2;
		float cx = (float)obj[num];
		float cy = (float)obj[num + 1] * scale;
		float cx2 = (float)obj[num + 2];
		float cy2 = (float)obj[num + 3] * scale;
		SetBezier(timeline, frame, value, bezier, time1, value1, cx, cy, cx2, cy2, time2, value2);
		return bezier + 1;
	}

	private static void SetBezier(CurveTimeline timeline, int frame, int value, int bezier, float time1, float value1, float cx1, float cy1, float cx2, float cy2, float time2, float value2)
	{
		timeline.SetBezier(bezier, frame, value, time1, value1, cx1, cy1, cx2, cy2, time2, value2);
	}

	private static float[] GetFloatArray(Dictionary<string, object> map, string name, float scale)
	{
		List<object> list = (List<object>)map[name];
		float[] array = new float[list.Count];
		if (scale == 1f)
		{
			int i = 0;
			for (int count = list.Count; i < count; i++)
			{
				array[i] = (float)list[i];
			}
		}
		else
		{
			int j = 0;
			for (int count2 = list.Count; j < count2; j++)
			{
				array[j] = (float)list[j] * scale;
			}
		}
		return array;
	}

	private static int[] GetIntArray(Dictionary<string, object> map, string name)
	{
		List<object> list = (List<object>)map[name];
		int[] array = new int[list.Count];
		int i = 0;
		for (int count = list.Count; i < count; i++)
		{
			array[i] = (int)(float)list[i];
		}
		return array;
	}

	private static float GetFloat(Dictionary<string, object> map, string name, float defaultValue)
	{
		if (!map.ContainsKey(name))
		{
			return defaultValue;
		}
		return (float)map[name];
	}

	private static int GetInt(Dictionary<string, object> map, string name, int defaultValue)
	{
		if (!map.ContainsKey(name))
		{
			return defaultValue;
		}
		return (int)(float)map[name];
	}

	private static int GetInt(Dictionary<string, object> map, string name)
	{
		if (!map.ContainsKey(name))
		{
			throw new ArgumentException("Named value not found: " + name);
		}
		return (int)(float)map[name];
	}

	private static bool GetBoolean(Dictionary<string, object> map, string name, bool defaultValue)
	{
		if (!map.ContainsKey(name))
		{
			return defaultValue;
		}
		return (bool)map[name];
	}

	private static string GetString(Dictionary<string, object> map, string name, string defaultValue)
	{
		if (!map.ContainsKey(name))
		{
			return defaultValue;
		}
		return (string)map[name];
	}

	private static float ToColor(string hexString, int colorIndex, int expectedLength = 8)
	{
		if (hexString.Length < expectedLength)
		{
			throw new ArgumentException("Color hexadecimal length must be " + expectedLength + ", received: " + hexString, "hexString");
		}
		return (float)Convert.ToInt32(hexString.Substring(colorIndex * 2, 2), 16) / 255f;
	}
}
