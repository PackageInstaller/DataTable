LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/4900671/cfg_skill_view_490067201.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �t       PlayCasterAnimation,animName=Skill03; PlayAudio,audioID = 6084,audioType=1; PlayCasterBindEffect,effectID=1259; PlayEffectAGridPos,effectID=2790,gridPosX=5,gridPosY=5; Wait,waitTime=1500; PlayEffectAGridPos,effectID=2789,gridPosX=5,gridPosY=5; ShowHideGameObject, isShow=0, goName=SceneRoot; Wait,waitTime=500; PlayMonsterVisible,visible = 0; Wait,waitTime=5000; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=700; ShowHideGameObject, isShow=1, goName=SceneRoot; Wait,waitTime=500; PlayMonsterVisible,visible = 1; PlayCasterBindEffect,effectID=1261; ��       DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=10; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,dataSourceHigher=62,label=playRangeEffect; PlayGridRangeEffect,effectID=480; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         %                                                                                                                     key   %   config    %      _ENV