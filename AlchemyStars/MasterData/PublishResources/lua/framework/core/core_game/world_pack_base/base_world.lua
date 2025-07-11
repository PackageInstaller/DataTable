LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/framework/core/core_game/world_pack_base/base_world.lua         X    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��A l�  
@ ��A l�  
@���A l  
@ ��A l@ 
@���A l� 
@ �@C l� 
@ ��C l  
@ ��C l@ 
@���C l� 
@ ��C l� 
@���C l  
@ ��C l@ 
@���C l� 
@ ��C l� 
@���C l  
@ ��C l@ 
@���C l� 
@ ��C l� 
@���C l  
@ ��C l@ 
@���C l� 
@ ��C l� 
@���C l  
@ ��C l@ 
@��& � "   requireworld_class
BaseWorldWorldConstructorDispose
BaseWorldDestroyAllEntityDestroyAllGroupDestroyServicesDestroySystemsCreateEntity
BaseWorldDestroyEntity
BaseWorldInternal_onComponentAddedInternal_onComponentRemovedInternal_onComponentReplacedEnterWorldUpdateWorld
ExitWorldGetUniqueComponent_GetUniqueComponentNameByIndex&_CheckUniqueCmptAvailableInRenderSideHasUniqueComponentHasUniqueComponentsHasAnyUniqueComponentSetUniqueComponentGetEntityByIDWorldHandleCommandsInternal_CreateSystemsInternal_CreateComponentsInternal_CreateServices           #       
@ ���� 
���� � 
������ 
���
 
 ��B � C�� 
� ���C � C�� 
�����C � D@D@ �
�D�  �
@D�& �    BW_WorldInfoBW_WEComponentsEnumBWCC_EComponentsEnumBW_WEMatchersBWCC_EMatchersBW_UniqueComponentsEnumBWCC_WUniqueComponentsEnumBW_Systems BW_ServicesBW_UniqueComponentsSortedDictionaryNew BW_Ev_OnUniqueComponentReplacedDelegateEvent_GEnalbeProfLog_checkCrossSide                                                                                  !   #      self       
worldInfo          _ENV %   6    	#   F @ G@� G�� �   d@ L�@ d@ L A d@ L@A d@ G�A L�� d� �  � �  � ���A �AB ����ǁ@_��@ �́@�A �@���A ��B�@ � C ��B�@ & �    
BaseWorldsuperDisposeDestroyAllEntityDestroyAllGroupDestroyServicesBW_UniqueComponentsSize       GetAt Clear BW_Ev_OnUniqueComponentReplaced         #   &   &   &   &   &   (   (   )   )   *   *   -   -   -   .   .   .   .   /   /   /   /   0   0   0   1   1   .   4   4   4   5   5   5   6      self    #   uniqueCmptCount   #   (for index)      (for limit)      (for step)      
cmptIndex      uniqueCmpt         _ENV 8   E       A   �@@ ��@  ���_�@��� A @ �@�M �  �  ����@@ �@A�@ & �           
_entitiesGetAt DestroyEntityClear           9   <   <   <   <   =   =   >   >   >   ?   ?   @   B   D   D   D   E      self       i      entity           G   M       F @ �@@ d � �b  @ �����A i�  �@�& �    ipairs_groupsDispose            H   H   H   H   I   I   J   J   H   H   M      self       (for generator)   
   (for state)   
   (for control)   
   _      group         _ENV O   T    	   G @ G@� b   � �G @ L@� d@ 
�@�& �    BW_ServicesDispose         	   P   P   P   P   Q   Q   Q   S   T      self    	        V   X       
@@�& �    BW_Systems            W   X      self            [   d       F @ G@� G�� �   d� � A J����@� ��A   G�A �@ � � ��A   GAB �@ ��� ��A   G�B �@ f  & �    
BaseWorldsuperCreateEntityWEComponentsEnumBW_WEComponentsEnumEv_OnComponentAdded	AddEventInternal_onComponentAddedEv_OnComponentRemovedInternal_onComponentRemovedEv_OnComponentReplacedInternal_onComponentReplaced            ]   ]   ]   ]   ]   _   _   `   `   `   `   `   a   a   a   a   a   b   b   b   b   b   c   d      self       e         _ENV f   i       � @ �@@��@�    � � ��   & �    
BaseWorldsuperDestroyEntity            h   h   h   h   h   h   h   i      self       entity          _ENV l   q       �@ �A�"  � �A��� $A�& �    WEC_OwnerEntityWEC_PostInitialize           m   n   n   n   o   o   o   q      self       entity       index       
component            s   w       �"  @ ��$A & �    WEC_PostRemoved           t   t   t   u   u   w      self       entity       index       
component            y   �       _ �@�G�b  @ �L�dA _@@��
A �G�@b  � �L�@�� dA�& �    WEC_PostRemoved WEC_OwnerEntityWEC_PostInitialize           z   z   {   {   {   |   |         �   �   �   �   �   �   �   �      self       entity       index       previousComponent       newComponent            �   �       L @ d@ L@@ d@ L�@ d@ G�@ � � �@ �@� �@ & �    Internal_CreateServicesInternal_CreateComponentsInternal_CreateSystemsBW_SystemsActivateReactiveSystemsInitialize           �   �   �   �   �   �   �   �   �   �   �   �      self       systems           �   �    	   � @ �@    �& � �@@�@ ̀@�@ & �    BW_SystemsExecuteCleanup        	   �   �   �   �   �   �   �   �   �      self    	   deltaTimeMS    	   systems   	        �   �    
   G @ _@� � ���� �@ ��� �@ � A �@ & �    BW_Systems 	TearDownDeactivateReactiveSystemsDestroySystems        
   �   �   �   �   �   �   �   �   �   �      self    
   systems   
        �   �    
    � @ �   ���@@ �   ����@  � ����@  ����@ @� 䀀 �A AFAA G��� ��  FBA GB�d� dA  ��B ��B � � ��   & �    EDITOR_checkCrossSide&_CheckUniqueCmptAvailableInRenderSide_GetUniqueComponentNameByIndex
ComponentLog
exception not available in render side. 
tracebackBW_UniqueComponentsFind             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self        index        
available	      	cmptName      fullCmptName         _ENV �   �       � @ �@@��@�@ �  & �    BW_WorldInfoBWCC_WUniqueComponentsEnumEL_RawStrArray           �   �   �   �   �   �      self       index       	cmptName           �   �       � @ �@@��  �  ��� A@ �� � �  �@A�A �A@�� $��GAB L���� d��"    �f �� � & �    debuggetinfo       S 
short_srcstringfind_r.luaBW_WorldInfoUniqueCmptAvailableInRender            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       index       
debugInfo      	filePath
      isRenderFile      
available         _ENV �   �    
   � @ �@@ � ����@  ��@  � � �  & �    BW_UniqueComponentsFind         
   �   �   �   �   �   �   �   �   �   �      self    
   index    
        �   �    
   � @ � � � ���A@ ́�@ 䁀��@ ��  � ��  *A�� � �  & �    pairsBW_UniqueComponentsFind             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       indices       (for generator)      (for state)      (for control)      _      v         _ENV �   �    
   � @ � � � ���A@ ́�@ 䁀_��@ ��� � ��  *A��   �  & �    pairsBW_UniqueComponentsFind             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       indices       (for generator)      (for state)      (for control)      _      v         _ENV �   �    	6   � @ @� 䀀�@  ���@@ ̀�@� � �@ ��@    @� �  � �@�& � �@@ � �@� 䀀_����@A �A@ �A�� $A� �A@ �A�� � $A �@ @  �� ��  $A��"   ��$A @��@ @  �� ��  $A�& � 	   HasUniqueComponentBW_UniqueComponentsInsert BW_Ev_OnUniqueComponentReplacedFind RemoveModifyDispose        6   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    6   index    6   cmpt    6   previousCmpt   6                 & �                     self       	entityID                    & �                     self       command_list              	      & �                	     self                    & �                     self                    & �                     self           X                                 #      %   6   %   8   E   8   G   M   G   O   T   O   V   X   V   [   d   [   f   i   f   l   q   l   s   w   s   y   �   y   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                   	                         _ENV