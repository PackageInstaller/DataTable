LuaS 

xV           (w@V@../PublishResources/lua/product/core_game/logic/helper/ai/action_cast_skill_base.lua         %    @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ ÀA l  
@ ÀA lÀ  
@ÀA l  
@ ÀA l@ 
@ÀA l 
@ ÀA lÀ 
@ÀA l  
@ &     requireai_node_new_classActionCastSkillBase
AINewNodeConstructorInitializeNodeActionCastSkillBaseGetWorkSkillIDOnBegin	OnUpdate_CalcAISkill_CastNormalSkill_CastSkill_HandleChessPetDead    	    	          
@@
À@
À@&     _world m_nWaitTaskID        m_nWaitSkillType                          self                   
   F@ GAÀGÀ  À   @ dA &     ActionCastSkillBasesuperInitializeNode         
                                    self    
   cfg    
   context    
   parentNode    
   configData    
      _ENV           D   f  &                             self                      G @ L@À d À Á@ A¤@&     m_entityOwnAISetMoveStateAIMoveStateMoveEnd                                       self       aiCmpt         _ENV !   5    *   L @ d b   @ !@À @@ Á  ¤@ A @A¦  A ÀAÇ B ¤ ¢     A @A¦   B @B¤ BÁB C¤¢   @ A @ ¤@  A @A¦  C   ¤¦  &     GetWorkSkillID        	PrintLogéæ¾æè½ï¼skillID = nilAINewNodeStatusFailure
AINewNodeIsEntityDeadm_entityOwnBuffComponentHasFlag
BuffFlagsBenumb3æ½æ¾æè½<éº»ç¹Buffä¸æ¾æè½>ï¼æè½ID = _CalcAISkill         *   "   "   #   #   #   #   $   $   $   %   %   %   (   (   (   (   (   (   )   )   )   -   -   -   -   -   -   -   -   -   .   .   .   .   /   /   /   3   3   3   4   5      self    *   	nSkillID   *   ret(   *      _ENV 7   R    	<    @ @@¤ Ç@ ÌÀÀA äAÁ $LÁAd 
@FB GAÂA LB ÁÁ   dA LC ÁÁ   dA LAC À dAFC GÁÃf @LD d b  LB ÁA   dA LC ÁA   dA LD À dAFC GÁÃf LB ÁÁ   dA FC GÅf &     m_entityOwnAI_worldGetServiceConfigGetSkillConfigDatam_nWaitSkillTypeGetSkillType
SkillTypeNormal	PrintLog!æ½æ¾æ®æ»æè½ï¼æè½ID = PrintDebugLog_CastNormalSkillAINewNodeStatusSuccess_IsAllAIMoveDone;ææAIç§»å¨ç»æï¼æ½æ¾éæ®æ»æè½ï¼æè½ID = _CastSkillKæ¬æ¬¡æ½æ¾éæ®æ»æè½å¤±è´¥ï¼éè¦ç­å¾ç§»å¨ç»æï¼æè½ID = Failure         <   9   9   9   ;   ;   ;   ;   =   =   =   >   >   >   @   @   @   @   @   A   A   A   A   B   B   B   B   C   C   C   D   D   D   D   G   G   G   G   H   H   H   H   I   I   I   I   J   J   J   K   K   K   K   M   M   M   M   O   O   O   R      self    <   skillID    <   aiCmpt   <   configService   <   skillConfigData
   <      _ENV T   j    1    @ A  @ ¤@ @ À@ ¤Ç@ Ì@Áä ÌÁä ÁA B$ AA ÁA B¤ ÁB ¤¢    AA A ÀB ¨C ÂC¤ ÌDGÃA LCÄd äB  ÌÄ@  äB ÌÂDGÃA  À äB§Aû&     
PrintLog2 CastNormalSkill skillID=_worldGetServiceSkillLogicGetBoardEntityAIRecorderm_entityOwnGetID       AttributesGetAttribute
DoubleAtk       AISkillResultNewSetCastSkillDirGetGridDirectionAddNormalAttackResultCalcAISkillResult         1   U   U   U   U   W   W   W   W   Y   Y   Y   Y   Y   [   [   [   \   ^   ^   ^   ^   ^   ^   ^   ^   _   b   b   b   b   d   d   d   e   e   e   e   e   f   f   f   f   h   h   h   h   h   b   j      self    1   skillID    1   skillLogicSvc   1   recorderCmpt   1   casterEntityID   1   	atkCount   1   (for index)   0   (for limit)   0   (for step)   0   i   /   	aiResult!   /      _ENV l       .    @ @@  ¤Ç @ ÌÀÀä Ì Áä AA A$ FÁA LÂd AÂBA B$ ¤A  ÁÂ  ¤AÃBC $ ¤A  Ã  @¤A ÁC  @ ¤A ADBA @ ¤AD ¤ ÌÁÄ@ äA&     _worldGetServiceSkillLogicGetBoardEntityAIRecorderm_entityOwnGetIDAISkillResultNewSetCastSkillDirGetGridDirectionSetCasterEntityIDSetParallelIDGetParallelIDAddSpellResult	PrintLog CastSkill skillID=CalcAISkillResult_HandleChessPetDeadSetAISkillResult_DeadChessList         .   n   n   n   n   p   p   p   p   p   r   r   r   t   t   t   u   u   u   u   u   v   v   v   w   w   w   w   x   x   x   x   z   z   z   z   {   {   {   {   {   }   }   ~   ~   ~         self    .   skillID    .   skillLogicSvc   .   recorderCmpt	   .   casterEntityID   .   	aiResult   .   deadChessPetEntityIDList*   .      _ENV           G @ L@À d @@ @_   &  G @ LÀÀ Á  d@Á ¤ ÌÁ @ ä@¦  &     _world
MatchType	MT_ChessGetServiceChessLogicGetDeadChessPetListDoChessPetListDeadLogic                                                                        self       	chessSvc      deadIDList         _ENV%                              	      	                              !   5   !   7   R   7   T   j   T   l      l                      _ENV