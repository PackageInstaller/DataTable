using System.Collections.Generic;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

namespace Unity.VisualScripting;

public class SerializationOperation
{
	public fsSerializer serializer { get; private set; }

	public List<Object> objectReferences { get; private set; }

	public SerializationOperation()
	{
		objectReferences = new List<Object>();
		serializer = new fsSerializer();
		serializer.AddConverter(new UnityObjectConverter());
		serializer.AddConverter(new RayConverter());
		serializer.AddConverter(new Ray2DConverter());
		serializer.AddConverter(new NamespaceConverter());
		serializer.AddConverter(new LooseAssemblyNameConverter());
		serializer.Context.Set(objectReferences);
	}

	public void Reset()
	{
		objectReferences.Clear();
	}
}
