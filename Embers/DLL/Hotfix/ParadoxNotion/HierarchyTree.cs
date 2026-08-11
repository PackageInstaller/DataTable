using System.Collections.Generic;

namespace ParadoxNotion;

public class HierarchyTree
{
	public class Element
	{
		private object _reference;

		private Element _parent;

		private List<Element> _children;

		public object reference => _reference;

		public Element parent => _parent;

		public IEnumerable<Element> children => _children;

		public Element(object reference)
		{
			_reference = reference;
		}

		public Element AddChild(Element child)
		{
			if (_children == null)
			{
				_children = new List<Element>();
			}
			child._parent = this;
			_children.Add(child);
			return child;
		}

		public void RemoveChild(Element child)
		{
			if (_children != null)
			{
				_children.Remove(child);
			}
		}

		public Element GetRoot()
		{
			Element element;
			for (element = _parent; element != null; element = element._parent)
			{
			}
			return element;
		}

		public Element FindReferenceElement(object target)
		{
			if (_reference == target)
			{
				return this;
			}
			if (_children == null)
			{
				return null;
			}
			for (int i = 0; i < _children.Count; i++)
			{
				Element element = _children[i].FindReferenceElement(target);
				if (element != null)
				{
					return element;
				}
			}
			return null;
		}

		public T GetFirstParentReferenceOfType<T>()
		{
			if (_reference is T)
			{
				return (T)_reference;
			}
			if (_parent == null)
			{
				return default(T);
			}
			return _parent.GetFirstParentReferenceOfType<T>();
		}

		public IEnumerable<T> GetAllChildrenReferencesOfType<T>()
		{
			if (_children == null)
			{
				yield break;
			}
			for (int i = 0; i < _children.Count; i++)
			{
				Element element = _children[i];
				if (element._reference is T)
				{
					yield return (T)element._reference;
				}
				foreach (T item in element.GetAllChildrenReferencesOfType<T>())
				{
					yield return item;
				}
			}
		}
	}
}
