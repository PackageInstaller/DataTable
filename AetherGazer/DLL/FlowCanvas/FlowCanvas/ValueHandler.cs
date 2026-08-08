using ParadoxNotion.Design;

namespace FlowCanvas;

[SpoofAOT]
public delegate T ValueHandler<T>();
public delegate T ValueHandler<T, Owner>(Owner owner);
