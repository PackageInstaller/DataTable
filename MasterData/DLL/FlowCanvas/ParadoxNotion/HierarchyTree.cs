using System.Collections.Generic;

namespace ParadoxNotion;

public class HierarchyTree
{
	public class Element
	{
		public object reference;

		public Element parent;

		public List<Element> children;

		public Element(object reference)
		{
			this.reference = reference;
			children = new List<Element>();
		}

		public void AddChild(Element child)
		{
			child.parent = this;
			children.Add(child);
		}

		public void RemoveChild(Element child)
		{
			children.Remove(child);
		}

		public Element GetRoot()
		{
			Element element;
			for (element = parent; element != null; element = element.parent)
			{
			}
			return element;
		}

		public Element FindReferenceElement(object target)
		{
			if (reference == target)
			{
				return this;
			}
			for (int i = 0; i < children.Count; i++)
			{
				Element element = children[i].FindReferenceElement(target);
				if (element != null)
				{
					return element;
				}
			}
			return null;
		}

		public T GetFirstParentReferenceOfType<T>()
		{
			if (reference is T)
			{
				return (T)reference;
			}
			if (parent == null)
			{
				return default(T);
			}
			return parent.GetFirstParentReferenceOfType<T>();
		}

		public List<T> GetAllChildrenReferencesOfType<T>()
		{
			List<T> list = new List<T>();
			for (int i = 0; i < children.Count; i++)
			{
				Element element = children[i];
				if (element.reference is T)
				{
					list.Add((T)element.reference);
				}
				list.AddRange(element.GetAllChildrenReferencesOfType<T>());
			}
			return list;
		}
	}
}
