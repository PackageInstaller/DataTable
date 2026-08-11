namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public delegate void RenderFunc<PassData>(PassData data, RenderGraphContext renderGraphContext) where PassData : class, new();
