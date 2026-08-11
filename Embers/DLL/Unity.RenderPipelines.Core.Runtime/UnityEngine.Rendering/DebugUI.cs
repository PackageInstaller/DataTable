using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;

namespace UnityEngine.Rendering;

public class DebugUI
{
	public class Container : Widget, IContainer
	{
		public ObservableList<Widget> children { get; private set; }

		public override Panel panel
		{
			get
			{
				return m_Panel;
			}
			internal set
			{
				m_Panel = value;
				foreach (Widget child in children)
				{
					child.panel = value;
				}
			}
		}

		public Container()
		{
			base.displayName = "";
			children = new ObservableList<Widget>();
			children.ItemAdded += OnItemAdded;
			children.ItemRemoved += OnItemRemoved;
		}

		public Container(string displayName, ObservableList<Widget> children)
		{
			base.displayName = displayName;
			this.children = children;
			children.ItemAdded += OnItemAdded;
			children.ItemRemoved += OnItemRemoved;
		}

		internal override void GenerateQueryPath()
		{
			base.GenerateQueryPath();
			foreach (Widget child in children)
			{
				child.GenerateQueryPath();
			}
		}

		protected virtual void OnItemAdded(ObservableList<Widget> sender, ListChangedEventArgs<Widget> e)
		{
			if (e.item != null)
			{
				e.item.panel = m_Panel;
				e.item.parent = this;
			}
			if (m_Panel != null)
			{
				m_Panel.SetDirty();
			}
		}

		protected virtual void OnItemRemoved(ObservableList<Widget> sender, ListChangedEventArgs<Widget> e)
		{
			if (e.item != null)
			{
				e.item.panel = null;
				e.item.parent = null;
			}
			if (m_Panel != null)
			{
				m_Panel.SetDirty();
			}
		}

		public override int GetHashCode()
		{
			int num = 17;
			num = num * 23 + base.queryPath.GetHashCode();
			foreach (Widget child in children)
			{
				num = num * 23 + child.GetHashCode();
			}
			return num;
		}
	}

	public class Foldout : Container, IValueField
	{
		public struct ContextMenuItem
		{
			public string displayName;

			public Action action;
		}

		public bool opened;

		public bool isHeader;

		public List<ContextMenuItem> contextMenuItems;

		public bool isReadOnly => false;

		public string[] columnLabels { get; set; }

		public string[] columnTooltips { get; set; }

		public Foldout()
		{
		}

		public Foldout(string displayName, ObservableList<Widget> children, string[] columnLabels = null, string[] columnTooltips = null)
			: base(displayName, children)
		{
			this.columnLabels = columnLabels;
			this.columnTooltips = columnTooltips;
		}

		public bool GetValue()
		{
			return opened;
		}

		object IValueField.GetValue()
		{
			return GetValue();
		}

		public void SetValue(object value)
		{
			SetValue((bool)value);
		}

		public object ValidateValue(object value)
		{
			return value;
		}

		public void SetValue(bool value)
		{
			opened = value;
		}
	}

	public class HBox : Container
	{
		public HBox()
		{
			base.displayName = "HBox";
		}
	}

	public class VBox : Container
	{
		public VBox()
		{
			base.displayName = "VBox";
		}
	}

	public class Table : Container
	{
		public class Row : Foldout
		{
			public Row()
			{
				base.displayName = "Row";
			}
		}

		public bool isReadOnly;

		private bool[] m_Header;

		public bool[] VisibleColumns
		{
			get
			{
				if (m_Header != null)
				{
					return m_Header;
				}
				int num = 0;
				if (base.children.Count != 0)
				{
					num = ((Container)base.children[0]).children.Count;
					for (int i = 1; i < base.children.Count; i++)
					{
						if (((Container)base.children[i]).children.Count != num)
						{
							Debug.LogError("All rows must have the same number of children.");
							return null;
						}
					}
				}
				m_Header = new bool[num];
				for (int j = 0; j < num; j++)
				{
					m_Header[j] = true;
				}
				return m_Header;
			}
		}

		public Table()
		{
			base.displayName = "Array";
		}

		public void SetColumnVisibility(int index, bool visible)
		{
			bool[] visibleColumns = VisibleColumns;
			if (index >= 0 && index <= visibleColumns.Length)
			{
				visibleColumns[index] = visible;
			}
		}

		public bool GetColumnVisibility(int index)
		{
			bool[] visibleColumns = VisibleColumns;
			if (index < 0 || index > visibleColumns.Length)
			{
				return false;
			}
			return visibleColumns[index];
		}

		protected override void OnItemAdded(ObservableList<Widget> sender, ListChangedEventArgs<Widget> e)
		{
			base.OnItemAdded(sender, e);
			m_Header = null;
		}

		protected override void OnItemRemoved(ObservableList<Widget> sender, ListChangedEventArgs<Widget> e)
		{
			base.OnItemRemoved(sender, e);
			m_Header = null;
		}
	}

	[Flags]
	public enum Flags
	{
		None = 0,
		EditorOnly = 2,
		RuntimeOnly = 4,
		EditorForceUpdate = 8
	}

	public abstract class Widget
	{
		public struct NameAndTooltip
		{
			public string name;

			public string tooltip;
		}

		protected Panel m_Panel;

		protected IContainer m_Parent;

		public Func<bool> isHiddenCallback;

		public virtual Panel panel
		{
			get
			{
				return m_Panel;
			}
			internal set
			{
				m_Panel = value;
			}
		}

		public virtual IContainer parent
		{
			get
			{
				return m_Parent;
			}
			internal set
			{
				m_Parent = value;
			}
		}

		public Flags flags { get; set; }

		public string displayName { get; set; }

		public string tooltip { get; set; }

		public string queryPath { get; private set; }

		public bool isEditorOnly => flags.HasFlag(Flags.EditorOnly);

		public bool isRuntimeOnly => flags.HasFlag(Flags.RuntimeOnly);

		public bool isInactiveInEditor
		{
			get
			{
				if (isRuntimeOnly)
				{
					return !Application.isPlaying;
				}
				return false;
			}
		}

		public bool isHidden => isHiddenCallback?.Invoke() ?? false;

		public NameAndTooltip nameAndTooltip
		{
			set
			{
				displayName = value.name;
				tooltip = value.tooltip;
			}
		}

		internal virtual void GenerateQueryPath()
		{
			queryPath = displayName.Trim();
			if (m_Parent != null)
			{
				queryPath = m_Parent.queryPath + " -> " + queryPath;
			}
		}

		public override int GetHashCode()
		{
			return queryPath.GetHashCode();
		}
	}

	public interface IContainer
	{
		ObservableList<Widget> children { get; }

		string displayName { get; set; }

		string queryPath { get; }
	}

	public interface IValueField
	{
		object GetValue();

		void SetValue(object value);

		object ValidateValue(object value);
	}

	public class Button : Widget
	{
		public Action action { get; set; }
	}

	public class Value : Widget
	{
		public float refreshRate = 0.1f;

		public Func<object> getter { get; set; }

		public Value()
		{
			base.displayName = "";
		}

		public object GetValue()
		{
			return getter();
		}
	}

	public abstract class Field<T> : Widget, IValueField
	{
		public Action<Field<T>, T> onValueChanged;

		public Func<T> getter { get; set; }

		public Action<T> setter { get; set; }

		object IValueField.ValidateValue(object value)
		{
			return ValidateValue((T)value);
		}

		public virtual T ValidateValue(T value)
		{
			return value;
		}

		object IValueField.GetValue()
		{
			return GetValue();
		}

		public T GetValue()
		{
			return getter();
		}

		public void SetValue(object value)
		{
			SetValue((T)value);
		}

		public void SetValue(T value)
		{
			T val = ValidateValue(value);
			if (!val.Equals(getter()))
			{
				setter(val);
				onValueChanged?.Invoke(this, val);
			}
		}
	}

	public class BoolField : Field<bool>
	{
	}

	public class HistoryBoolField : BoolField
	{
		public Func<bool>[] historyGetter { get; set; }

		public int historyDepth
		{
			get
			{
				Func<bool>[] array = historyGetter;
				if (array == null)
				{
					return 0;
				}
				return array.Length;
			}
		}

		public bool GetHistoryValue(int historyIndex)
		{
			return historyGetter[historyIndex]();
		}
	}

	public class IntField : Field<int>
	{
		public Func<int> min;

		public Func<int> max;

		public int incStep = 1;

		public int intStepMult = 10;

		public override int ValidateValue(int value)
		{
			if (min != null)
			{
				value = Mathf.Max(value, min());
			}
			if (max != null)
			{
				value = Mathf.Min(value, max());
			}
			return value;
		}
	}

	public class UIntField : Field<uint>
	{
		public Func<uint> min;

		public Func<uint> max;

		public uint incStep = 1u;

		public uint intStepMult = 10u;

		public override uint ValidateValue(uint value)
		{
			if (min != null)
			{
				value = (uint)Mathf.Max((int)value, (int)min());
			}
			if (max != null)
			{
				value = (uint)Mathf.Min((int)value, (int)max());
			}
			return value;
		}
	}

	public class FloatField : Field<float>
	{
		public Func<float> min;

		public Func<float> max;

		public float incStep = 0.1f;

		public float incStepMult = 10f;

		public int decimals = 3;

		public override float ValidateValue(float value)
		{
			if (min != null)
			{
				value = Mathf.Max(value, min());
			}
			if (max != null)
			{
				value = Mathf.Min(value, max());
			}
			return value;
		}
	}

	private static class EnumUtility
	{
		internal static GUIContent[] MakeEnumNames(Type enumType)
		{
			return ((IEnumerable<FieldInfo>)enumType.GetFields(BindingFlags.Static | BindingFlags.Public)).Select((Func<FieldInfo, GUIContent>)delegate(FieldInfo fieldInfo)
			{
				//IL_0041: Unknown result type (might be due to invalid IL or missing references)
				//IL_0047: Expected O, but got Unknown
				//IL_0026: Unknown result type (might be due to invalid IL or missing references)
				//IL_002c: Expected O, but got Unknown
				object[] customAttributes = fieldInfo.GetCustomAttributes(typeof(InspectorNameAttribute), inherit: false);
				return (customAttributes.Length == 0) ? new GUIContent(Regex.Replace(fieldInfo.Name, "([a-z](?=[A-Z])|[A-Z](?=[A-Z][a-z]))", "$1 ")) : new GUIContent(((InspectorNameAttribute)customAttributes.First()).displayName);
			}).ToArray();
		}

		internal static int[] MakeEnumValues(Type enumType)
		{
			Array values = Enum.GetValues(enumType);
			int[] array = new int[values.Length];
			for (int i = 0; i < values.Length; i++)
			{
				array[i] = (int)values.GetValue(i);
			}
			return array;
		}
	}

	public class EnumField : Field<int>
	{
		public GUIContent[] enumNames;

		public int[] enumValues;

		internal int[] quickSeparators;

		internal int[] indexes;

		public Func<int> getIndex { get; set; }

		public Action<int> setIndex { get; set; }

		public int currentIndex
		{
			get
			{
				return getIndex();
			}
			set
			{
				setIndex(value);
			}
		}

		public Type autoEnum
		{
			set
			{
				enumNames = EnumUtility.MakeEnumNames(value);
				enumValues = EnumUtility.MakeEnumValues(value);
				InitIndexes();
				InitQuickSeparators();
			}
		}

		internal void InitQuickSeparators()
		{
			IEnumerable<string> source = enumNames.Select(delegate(GUIContent x)
			{
				string[] array = x.text.Split('/');
				return (array.Length == 1) ? "" : array[0];
			});
			quickSeparators = new int[source.Distinct().Count()];
			string text = null;
			int num = 0;
			int num2 = 0;
			for (; num < quickSeparators.Length; num++)
			{
				string text2 = source.ElementAt(num2);
				while (text == text2)
				{
					text2 = source.ElementAt(++num2);
				}
				text = text2;
				quickSeparators[num] = num2++;
			}
		}

		internal void InitIndexes()
		{
			if (enumNames == null)
			{
				enumNames = (GUIContent[])(object)new GUIContent[0];
			}
			indexes = new int[enumNames.Length];
			for (int i = 0; i < enumNames.Length; i++)
			{
				indexes[i] = i;
			}
		}
	}

	public class HistoryEnumField : EnumField
	{
		public Func<int>[] historyIndexGetter { get; set; }

		public int historyDepth
		{
			get
			{
				Func<int>[] array = historyIndexGetter;
				if (array == null)
				{
					return 0;
				}
				return array.Length;
			}
		}

		public int GetHistoryValue(int historyIndex)
		{
			return historyIndexGetter[historyIndex]();
		}
	}

	public class BitField : Field<Enum>
	{
		private Type m_EnumType;

		public GUIContent[] enumNames { get; private set; }

		public int[] enumValues { get; private set; }

		public Type enumType
		{
			get
			{
				return m_EnumType;
			}
			set
			{
				m_EnumType = value;
				enumNames = EnumUtility.MakeEnumNames(value);
				enumValues = EnumUtility.MakeEnumValues(value);
			}
		}
	}

	public class ColorField : Field<Color>
	{
		public bool hdr;

		public bool showAlpha = true;

		public bool showPicker = true;

		public float incStep = 0.025f;

		public float incStepMult = 5f;

		public int decimals = 3;

		public override Color ValidateValue(Color value)
		{
			if (!hdr)
			{
				value.r = Mathf.Clamp01(value.r);
				value.g = Mathf.Clamp01(value.g);
				value.b = Mathf.Clamp01(value.b);
				value.a = Mathf.Clamp01(value.a);
			}
			return value;
		}
	}

	public class Vector2Field : Field<Vector2>
	{
		public float incStep = 0.025f;

		public float incStepMult = 10f;

		public int decimals = 3;
	}

	public class Vector3Field : Field<Vector3>
	{
		public float incStep = 0.025f;

		public float incStepMult = 10f;

		public int decimals = 3;
	}

	public class Vector4Field : Field<Vector4>
	{
		public float incStep = 0.025f;

		public float incStepMult = 10f;

		public int decimals = 3;
	}

	public class MessageBox : Widget
	{
		public enum Style
		{
			Info,
			Warning,
			Error
		}

		public Style style;
	}

	public class Panel : IContainer, IComparable<Panel>
	{
		public Flags flags { get; set; }

		public string displayName { get; set; }

		public int groupIndex { get; set; }

		public string queryPath => displayName;

		public bool isEditorOnly => (flags & Flags.EditorOnly) != 0;

		public bool isRuntimeOnly => (flags & Flags.RuntimeOnly) != 0;

		public bool isInactiveInEditor
		{
			get
			{
				if (isRuntimeOnly)
				{
					return !Application.isPlaying;
				}
				return false;
			}
		}

		public bool editorForceUpdate => (flags & Flags.EditorForceUpdate) != 0;

		public ObservableList<Widget> children { get; private set; }

		public event Action<Panel> onSetDirty = delegate
		{
		};

		public Panel()
		{
			children = new ObservableList<Widget>();
			children.ItemAdded += OnItemAdded;
			children.ItemRemoved += OnItemRemoved;
		}

		protected virtual void OnItemAdded(ObservableList<Widget> sender, ListChangedEventArgs<Widget> e)
		{
			if (e.item != null)
			{
				e.item.panel = this;
				e.item.parent = this;
			}
			SetDirty();
		}

		protected virtual void OnItemRemoved(ObservableList<Widget> sender, ListChangedEventArgs<Widget> e)
		{
			if (e.item != null)
			{
				e.item.panel = null;
				e.item.parent = null;
			}
			SetDirty();
		}

		public void SetDirty()
		{
			foreach (Widget child in children)
			{
				child.GenerateQueryPath();
			}
			onSetDirty(this);
		}

		public override int GetHashCode()
		{
			int num = 17;
			num = num * 23 + displayName.GetHashCode();
			foreach (Widget child in children)
			{
				num = num * 23 + child.GetHashCode();
			}
			return num;
		}

		int IComparable<Panel>.CompareTo(Panel other)
		{
			if (other != null)
			{
				return groupIndex.CompareTo(other.groupIndex);
			}
			return 1;
		}
	}
}
