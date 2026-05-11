using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DNFBDmp {
	public class Utils {
		// Straight outta Stack Overflow
		public static string replaceLast(string text, string search, string replace) {
			int pos = text.LastIndexOf(search);
			if (pos < 0)
				return text;
			return string.Concat(text.AsSpan(0, pos), replace, text.AsSpan(pos + search.Length));
		}

	public static string cleanupClassName(string name) {
		// Regex anyone ? i don't do that so here's a bunch of replaces...
		name = name.Replace(".", "_").Replace("/", "_").Replace("+", "_")
				.Replace("<", "_").Replace("`", "_").Replace(">", "_")
				.Replace("[", "A").Replace("]", "_").Replace(",", "_");
		// Try to shorten the name because std::filesytem implem of windows doesn't handle long paths
		// And flatc uses it without check for a longpath and applying a botch
		// I fucking hate windows so god damn much, fuck you microsoft you piece of shit
		name = name.Replace("System_Collections_Generic_Dictionary","Dict")
				.Replace("Torappu_ListDict","ListDict")
				.Replace("System_Collections_Generic_List","List");
		if (name.StartsWith("TBL_")) {
			name = name.Substring(4);  // 去掉"TBL_"
		}
		
		return name;
	}
	}
}
