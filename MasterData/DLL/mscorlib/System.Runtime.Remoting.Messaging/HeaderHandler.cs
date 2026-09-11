using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Messaging;

[ComVisible(true)]
public delegate object HeaderHandler(Header[] headers);
