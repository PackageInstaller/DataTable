LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1905/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2900221/cfg_skill_view_500208.lua         7   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� � kB� �@�� ��  A�  �A �A  B  A� �B  � � A �C �� � A �B ����@��AA �A �� B  A� �B �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �      �       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=2; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=967,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,bodyArea=4; PlayTargetAddBuff,buffID=20011; Wait,waitTime=200; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; &       effectIDList�      �      �      1      5      �      �      � PlayTransformation; PlayCasterAddBuff,buffID=30241,remove=1; PlayCasterAddBuff,buffID=30243; PlayCasterRenderState,renderState=0;         7                                                                                                                                                                           key   7   config2   7      _ENV