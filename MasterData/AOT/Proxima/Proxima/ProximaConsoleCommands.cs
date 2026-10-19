using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Proxima;

internal class ProximaConsoleCommands
{
	[ProximaCommand("Scene", "ld", "Load scene by name or build index. If additive is true, the scene is added to the current scene.", "ld SampleScene", "Loading scene SampleScene.")]
	public static string Load(string sceneOrIndex, bool additive = false)
	{
		int result = -1;
		if (!int.TryParse(sceneOrIndex, out result))
		{
			result = -1;
			for (int i = 0; i < SceneManager.sceneCountInBuildSettings; i++)
			{
				if (SceneUtility.GetScenePathByBuildIndex(i).EndsWith(sceneOrIndex + ".unity", StringComparison.OrdinalIgnoreCase))
				{
					result = i;
					break;
				}
			}
		}
		if (result < 0 || result >= SceneManager.sceneCountInBuildSettings)
		{
			throw new Exception("Scene " + sceneOrIndex + " not found. Make sure it is added to the build settings.");
		}
		SceneManager.LoadSceneAsync(result, additive ? LoadSceneMode.Additive : LoadSceneMode.Single);
		return "Loading scene " + sceneOrIndex + ".";
	}

	[ProximaCommand("Scene", "ul", "Unload scene by name or build index.", "ul SampleScene", "Unloading scene SampleScene.")]
	public static string Unload(string sceneOrIndex)
	{
		if (int.TryParse(sceneOrIndex, out var result))
		{
			SceneManager.UnloadSceneAsync(result);
			return "Unloading scene " + sceneOrIndex + ".";
		}
		for (int num = SceneManager.sceneCount - 1; num >= 0; num--)
		{
			Scene sceneAt = SceneManager.GetSceneAt(num);
			if (sceneAt.name.Equals(sceneOrIndex, StringComparison.OrdinalIgnoreCase))
			{
				SceneManager.UnloadSceneAsync(sceneAt);
				return "Unloading scene " + sceneAt.name + ".";
			}
		}
		throw new Exception("Scene " + sceneOrIndex + " not found.");
	}

	[ProximaCommand("GameObject", "i", "Instantiate a prefab by name with optional position, rotation, and parent transform.", "i SamplePrefab [0, 1, 0] [0, 45, 0] cube.transform", "Instantiated SamplePrefab(Clone) [123].")]
	public static string Instantiate(string prefabName, PropertyOrValue<Vector3> position = default(PropertyOrValue<Vector3>), PropertyOrValue<Quaternion> rotation = default(PropertyOrValue<Quaternion>), PropertyOrValue<Transform> parent = default(PropertyOrValue<Transform>))
	{
		GameObject gameObject = Resources.Load<GameObject>(prefabName);
		if (!gameObject)
		{
			throw new Exception("Prefab " + prefabName + " not found. Make sure it's in a Resources folder.");
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject, position.GetOrDefault(), rotation.GetOrDefault(Quaternion.identity), parent.GetOrDefault());
		return $"Instantiated {gameObject2.name} [{gameObject2.GetInstanceID()}].";
	}

	[ProximaCommand("GameObject", "x", "Destroy all game objects with the given name.", "x cube*", "Destroyed Cube1 [123]\nDestroyed Cube2 [456]\nDestroyed Cube3 [789]")]
	public static string Destroy(string name)
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			stringBuilder.AppendLine($"Destroyed {item.name} [{item.GetInstanceID()}]");
			UnityEngine.Object.Destroy(item);
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "ls", "List all game objects with the given name.", "ls cube*", "Cube1 [123]\nCube2 [456]\nCube3 [789]")]
	public static string List(string name = "*")
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in ProximaCommandHelpers.FindGameObjects(name))
		{
			stringBuilder.AppendLine($"{item.name} [{item.GetInstanceID()}]");
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "mv", "Move all game objects with the given name to the given position.", "mv cube* [0, 1, 0]", "Moved Cube1 [123] to [0, 1, 0]\nMoved Cube2 [456] to [0, 1, 0]\nMoved Cube3 [789] to [0, 1, 0]")]
	public static string Move(string name, PropertyOrValue<Vector3> position, PropertyOrValue<bool> local = default(PropertyOrValue<bool>))
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		Vector3 vector = position.Get();
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			if (local.GetOrDefault(defaultValue: false))
			{
				item.transform.localPosition = vector;
			}
			else
			{
				item.transform.position = vector;
			}
			stringBuilder.AppendLine($"Moved {item.name} [{item.GetInstanceID()}] to {ProximaSerialization.Serialize(vector, pretty: true)}");
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "rt", "Rotate all game objects with the given name to the given rotation.", "rt cube* [0, 45, 0]", "Rotated Cube1 [123] to [0, 45, 0]\nRotated Cube2 [456] to [0, 45, 0]\nRotated Cube3 [789] to [0, 45, 0]")]
	public static string Rotate(string name, PropertyOrValue<Quaternion> rotation, PropertyOrValue<bool> local = default(PropertyOrValue<bool>))
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		Quaternion quaternion = rotation.Get();
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			if (local.GetOrDefault(defaultValue: false))
			{
				item.transform.localRotation = quaternion;
			}
			else
			{
				item.transform.rotation = quaternion;
			}
			stringBuilder.AppendLine($"Rotated {item.name} [{item.GetInstanceID()}] to {ProximaSerialization.Serialize(quaternion, pretty: true)}");
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "sc", "Scale all game objects with the given name to the given scale.", "sc cube* [2, 2, 2]", "Scaled Cube1 [123] to [2, 2, 2]\nScaled Cube2 [456] to [2, 2, 2]\nScaled Cube3 [789] to [2, 2, 2]")]
	public static string Scale(string name, PropertyOrValue<Vector3> scale)
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		Vector3 vector = scale.Get();
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			item.transform.localScale = vector;
			stringBuilder.AppendLine($"Scaled {item.name} [{item.GetInstanceID()}] to {ProximaSerialization.Serialize(vector, pretty: true)}");
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "lk", "Look at the given target.", "lk cube* player1.transform.position", "Rotated Cube1 [123] to [0, 1, 0]\nRotated Cube2 [456] to [0, 1, 0]\nRotated Cube3 [789] to [0, 1, 0]")]
	public static string LookAt(string name, PropertyOrValue<Vector3> target, PropertyOrValue<Vector3> worldUp = default(PropertyOrValue<Vector3>))
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		Vector3 vector = target.Get();
		Vector3 orDefault = worldUp.GetOrDefault();
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			if (orDefault != default(Vector3))
			{
				item.transform.LookAt(vector, orDefault);
			}
			else
			{
				item.transform.LookAt(vector);
			}
			stringBuilder.AppendLine($"Rotated {item.name} [{item.GetInstanceID()}] to {ProximaSerialization.Serialize(vector, pretty: true)}");
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "ac", "Add the component to all gameObjects with the given name.", "ac cube* Rigidbody", "Added Rigidbody to Cube1 [123]\nAdded Rigidbody to Cube2 [456]\nAdded Rigidbody to Cube3 [789]")]
	public static string AddComponent(string name, string component)
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		Type type = ProximaCommandHelpers.FindFirstComponentType(component);
		if (type == null)
		{
			throw new Exception("Component type " + component + " not found.");
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			item.AddComponent(type);
			stringBuilder.AppendLine($"Added {type.Name} to {item.name} [{item.GetInstanceID()}]");
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "rc", "Remove the component from all gameObjects with the given name.", "rc cube* Rigidbody", "Removed Rigidbody from Cube1 [123]\nRemoved Rigidbody from Cube2 [456]\nRemoved Rigidbody from Cube3 [789]")]
	public static string RemoveComponent(string name, string component)
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		Type type = ProximaCommandHelpers.FindFirstComponentType(component);
		if (type == null)
		{
			throw new Exception("Component type " + component + " not found.");
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			Component component2 = item.GetComponent(type);
			if (component2 != null)
			{
				UnityEngine.Object.Destroy(component2);
				stringBuilder.AppendLine($"Removed {type.Name} from {item.name} [{item.GetInstanceID()}]");
			}
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "sm", "Call a method on all gameObjects with the given name using SendMessage.", "sm cube* OnHit", "Sent message OnHit to Cube1 [123]\nSent message OnHit to Cube2 [456]\nSent message OnHit to Cube3 [789]")]
	public static string SendMessage(string name, string method)
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			item.SendMessage(method, null, SendMessageOptions.DontRequireReceiver);
			stringBuilder.AppendLine($"Sent message {method} to {item.name} [{item.GetInstanceID()}]");
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("General", "s", "Set the value of the given property. Can be used with most gameObject properties, component properties, and some statics including: Application, Time, Physics, Screen, AudioSettings, QualitySettings, Input, Physics2D.", "s cube*.transform.position [1, 2, 3]", "Set Cube1 [123] to [1, 2, 3]\nSet Cube2 [456] to [1, 2, 3]\nSet Cube3 [789] to [1, 2, 3]")]
	public static string Set(string property, PropertyOrValue<object> value)
	{
		List<PropertyOrField> list = ProximaCommandHelpers.FindProperties(property);
		StringBuilder stringBuilder = new StringBuilder();
		foreach (PropertyOrField item in list)
		{
			if (item.CanWrite)
			{
				object obj = value.Get(item.Type);
				item.SetValue(obj);
				stringBuilder.AppendLine("Set " + item.Descriptor + " to " + ProximaSerialization.Serialize(obj, pretty: true));
			}
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("General", "g", "Get the value of the given property. Can be used with most gameObject properties, component properties, and some statics including: Application, Time, Physics, Screen, AudioSettings, QualitySettings, Input, Physics2D.", "g cube*.transform.position", "Cube1 [123] [1, 2, 3]\nCube2 [456] [1, 2, 3]\nCube3 [789] [1, 2, 3]")]
	public static string Get(string pattern)
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (PropertyOrField item in ProximaCommandHelpers.FindProperties(pattern))
		{
			stringBuilder.Append(item.Descriptor + " ");
			stringBuilder.AppendLine(ProximaSerialization.Serialize(item.GetValue(), pretty: true));
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "comp", "Get the components of the given gameObjects.", "comp cube1", "Cube1 [123] Components:\n  Transform\n  MeshFilter\n  MeshRenderer")]
	public static string GetComponents(string name)
	{
		StringBuilder stringBuilder = new StringBuilder();
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		for (int i = 0; i < list.Count; i++)
		{
			if (i > 0)
			{
				stringBuilder.AppendLine();
			}
			GameObject gameObject = list[i];
			stringBuilder.AppendLine(gameObject.name + " [" + gameObject.GetInstanceID() + "] Components: ");
			Component[] components = gameObject.GetComponents<Component>();
			foreach (Component component in components)
			{
				stringBuilder.AppendLine("  " + component.GetType().Name);
			}
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "e", "Enable the given gameObjects.", "e cube*", "Enabled Cube1 [123]\nEnabled Cube2 [456]\nEnabled Cube3 [789]")]
	public static string Enable(string name)
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			item.SetActive(value: true);
			stringBuilder.AppendLine($"Enabled {item.name} [{item.GetInstanceID()}]");
		}
		return stringBuilder.ToString();
	}

	[ProximaCommand("GameObject", "d", "Disable the given gameObjects.", "d cube*", "Disabled Cube1 [123]\nDisabled Cube2 [456]\nDisabled Cube3 [789]")]
	public static string Disable(string name)
	{
		List<GameObject> list = ProximaCommandHelpers.FindGameObjects(name);
		StringBuilder stringBuilder = new StringBuilder();
		foreach (GameObject item in list)
		{
			item.SetActive(value: false);
			stringBuilder.AppendLine($"Disabled {item.name} [{item.GetInstanceID()}]");
		}
		return stringBuilder.ToString();
	}
}
