return {
	Play112062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H02 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02")
				var_4_0.name = "H02"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H02 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H02

				arg_1_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = manager.ui.mainCamera.transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_8.localPosition
			end

			local var_4_9 = 0.6

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_9 then
				local var_4_10, var_4_11 = math.modf((arg_1_1.time_ - 2) / 0.066)

				var_4_8.localPosition = Vector3.New(var_4_11 * 0.13, var_4_11 * 0.13, var_4_11 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 2 + var_4_9 and arg_1_1.time_ < 2 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = arg_1_1.var_.shakeOldPos
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense.awb")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 1.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112062001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 52 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 52)

				if (52 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 52)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112062002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112062002
		arg_7_1.duration_ = 4.3

		local var_7_0 = {
			ja = 4.3,
			ko = 2.866,
			zh = 3.3,
			en = 2.366
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play112062003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "1081ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["1081ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["1081ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["1081ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["1081ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1081ui_story = var_10_3.localPosition
			end

			local var_10_4 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_7_1.time_ - 0) / var_10_4)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_10_5 = arg_7_1.actors_["1081ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1081ui_story == nil then
				arg_7_1.var_.characterEffect1081ui_story = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_6 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 and not isNil(var_10_5) then
				if arg_7_1.var_.characterEffect1081ui_story and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1081ui_story then
				arg_7_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_10_8 = 0
			local var_10_9 = 0.275

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_8 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_10 = arg_7_1:GetWordFromCfg(112062002)
				local var_10_11 = arg_7_1:FormatText(var_10_10.content)

				arg_7_1.text_.text = var_10_11

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_13 = 11 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 11)

				if (11 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_11) / 11)) > 0 and var_10_9 < var_10_13 then
					arg_7_1.talkMaxDuration = var_10_13

					if var_10_13 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_13 + var_10_8
					end
				end

				arg_7_1.text_.text = var_10_11
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112062", "112062002", "story_v_out_112062.awb") ~= 0 then
					local var_10_14 = manager.audio:GetVoiceLength("story_v_out_112062", "112062002", "story_v_out_112062.awb") / 1000

					if var_10_14 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_14 + var_10_8
					end

					if var_10_10.prefab_name ~= "" and arg_7_1.actors_[var_10_10.prefab_name] ~= nil then
						local var_10_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_10.prefab_name].transform, "story_v_out_112062", "112062002", "story_v_out_112062.awb")

						arg_7_1:RecordAudio("112062002", var_10_15)
						arg_7_1:RecordAudio("112062002", var_10_15)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112062", "112062002", "story_v_out_112062.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112062", "112062002", "story_v_out_112062.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_16 = math.max(var_10_9, arg_7_1.talkMaxDuration)

			if var_10_8 <= arg_7_1.time_ and arg_7_1.time_ < var_10_8 + var_10_16 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_8) / var_10_16

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_8 + var_10_16 and arg_7_1.time_ < var_10_8 + var_10_16 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play112062003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 112062003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play112062004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1081ui_story = arg_11_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).z)
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles = arg_11_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1081ui_story"].transform.position).z)
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1081ui_story"].transform.localEulerAngles = arg_11_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_14_1 = 0
			local var_14_2 = 0.325

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_3 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(112062003).content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 13 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 13)

				if (13 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 13)) > 0 and var_14_2 < var_14_5 then
					arg_11_1.talkMaxDuration = var_14_5

					if var_14_5 + var_14_1 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + var_14_1
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_6 = math.max(var_14_2, arg_11_1.talkMaxDuration)

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_6 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_1) / var_14_6

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_1 + var_14_6 and arg_11_1.time_ < var_14_1 + var_14_6 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play112062004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 112062004
		arg_15_1.duration_ = 4.3

		local var_15_0 = {
			ja = 4.3,
			ko = 2.566,
			zh = 2,
			en = 2.133
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play112062005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_18_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_15_1.stage_.transform)

				var_18_0.name = "1039ui_story"
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1039ui_story"] = var_18_0

				local var_18_1 = var_18_0:GetComponentInChildren(typeof(CharacterEffect))

				var_18_1.enabled = true

				local var_18_2 = GameObjectTools.GetOrAddComponent(var_18_0, typeof(DynamicBoneHelper))

				if var_18_2 then
					var_18_2:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_1.transform, false)

				arg_15_1.var_["1039ui_story" .. "Animator"] = var_18_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_15_1.var_["1039ui_story" .. "LipSync"] = var_18_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_3 = arg_15_1.actors_["1039ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1039ui_story = var_18_3.localPosition
			end

			local var_18_4 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				var_18_3.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_15_1.time_ - 0) / var_18_4)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				var_18_3.localPosition = Vector3.New(0, -1.01, -5.9)
				var_18_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_3.position).x, (manager.ui.mainCamera.transform.position - var_18_3.position).y, (manager.ui.mainCamera.transform.position - var_18_3.position).z)
				var_18_3.localEulerAngles.z = 0
				var_18_3.localEulerAngles.x = 0
				var_18_3.localEulerAngles = var_18_3.localEulerAngles
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_18_5 = arg_15_1.actors_["1039ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1039ui_story == nil then
				arg_15_1.var_.characterEffect1039ui_story = var_18_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_6 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_6 and not isNil(var_18_5) then
				if arg_15_1.var_.characterEffect1039ui_story and not isNil(var_18_5) then
					arg_15_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_6 and arg_15_1.time_ < 0 + var_18_6 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1039ui_story then
				arg_15_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_18_8 = 0
			local var_18_9 = 0.25

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_10 = arg_15_1:GetWordFromCfg(112062004)
				local var_18_11 = arg_15_1:FormatText(var_18_10.content)

				arg_15_1.text_.text = var_18_11

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_13 = 10 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 10)

				if (10 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 10)) > 0 and var_18_9 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13

					if var_18_13 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_8
					end
				end

				arg_15_1.text_.text = var_18_11
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112062", "112062004", "story_v_out_112062.awb") ~= 0 then
					local var_18_14 = manager.audio:GetVoiceLength("story_v_out_112062", "112062004", "story_v_out_112062.awb") / 1000

					if var_18_14 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_14 + var_18_8
					end

					if var_18_10.prefab_name ~= "" and arg_15_1.actors_[var_18_10.prefab_name] ~= nil then
						local var_18_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_10.prefab_name].transform, "story_v_out_112062", "112062004", "story_v_out_112062.awb")

						arg_15_1:RecordAudio("112062004", var_18_15)
						arg_15_1:RecordAudio("112062004", var_18_15)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_112062", "112062004", "story_v_out_112062.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_112062", "112062004", "story_v_out_112062.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_16 = math.max(var_18_9, arg_15_1.talkMaxDuration)

			if var_18_8 <= arg_15_1.time_ and arg_15_1.time_ < var_18_8 + var_18_16 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_8) / var_18_16

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_8 + var_18_16 and arg_15_1.time_ < var_18_8 + var_18_16 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play112062005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 112062005
		arg_19_1.duration_ = 9.7

		local var_19_0 = {
			ja = 7.233,
			ko = 6.933,
			zh = 6.8,
			en = 9.7
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play112062006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_22_0 = 0
			local var_22_1 = 0.725

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_2 = arg_19_1:GetWordFromCfg(112062005)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 29 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_3) / 29)

				if (29 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_3) / 29)) > 0 and var_22_1 < var_22_5 then
					arg_19_1.talkMaxDuration = var_22_5

					if var_22_5 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112062", "112062005", "story_v_out_112062.awb") ~= 0 then
					local var_22_6 = manager.audio:GetVoiceLength("story_v_out_112062", "112062005", "story_v_out_112062.awb") / 1000

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end

					if var_22_2.prefab_name ~= "" and arg_19_1.actors_[var_22_2.prefab_name] ~= nil then
						local var_22_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_2.prefab_name].transform, "story_v_out_112062", "112062005", "story_v_out_112062.awb")

						arg_19_1:RecordAudio("112062005", var_22_7)
						arg_19_1:RecordAudio("112062005", var_22_7)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_112062", "112062005", "story_v_out_112062.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_112062", "112062005", "story_v_out_112062.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_8 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_8 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_8

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_8 and arg_19_1.time_ < var_22_0 + var_22_8 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play112062006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 112062006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play112062007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1039ui_story = arg_23_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1039ui_story"].transform.position).z)
				arg_23_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1039ui_story"].transform.localEulerAngles = arg_23_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1039ui_story"].transform.position).z)
				arg_23_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1039ui_story"].transform.localEulerAngles = arg_23_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_26_1 = 0
			local var_26_2 = 0.2

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(112062006).content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 8 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 8)

				if (8 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 8)) > 0 and var_26_2 < var_26_5 then
					arg_23_1.talkMaxDuration = var_26_5

					if var_26_5 + var_26_1 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + var_26_1
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_6 = math.max(var_26_2, arg_23_1.talkMaxDuration)

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_6 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_1) / var_26_6

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_1 + var_26_6 and arg_23_1.time_ < var_26_1 + var_26_6 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play112062007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 112062007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play112062008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.225

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(112062007).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 9 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 9)

				if (9 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 9)) > 0 and var_30_0 < var_30_3 then
					arg_27_1.talkMaxDuration = var_30_3

					if var_30_3 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_3 + 0
					end
				end

				arg_27_1.text_.text = var_30_1
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_4 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_4

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play112062008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 112062008
		arg_31_1.duration_ = 2

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play112062009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1081ui_story = arg_31_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1081ui_story"].transform.position).z)
				arg_31_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1081ui_story"].transform.localEulerAngles = arg_31_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_31_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1081ui_story"].transform.position).z)
				arg_31_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1081ui_story"].transform.localEulerAngles = arg_31_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_34_1 = arg_31_1.actors_["1081ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1081ui_story == nil then
				arg_31_1.var_.characterEffect1081ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1081ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1081ui_story then
				arg_31_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_34_4 = 0
			local var_34_5 = 0.1

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(112062008)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 4 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 4)

				if (4 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 4)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112062", "112062008", "story_v_out_112062.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_112062", "112062008", "story_v_out_112062.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_out_112062", "112062008", "story_v_out_112062.awb")

						arg_31_1:RecordAudio("112062008", var_34_11)
						arg_31_1:RecordAudio("112062008", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_112062", "112062008", "story_v_out_112062.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_112062", "112062008", "story_v_out_112062.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play112062009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 112062009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play112062010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1081ui_story"]) and arg_35_1.var_.characterEffect1081ui_story == nil then
				arg_35_1.var_.characterEffect1081ui_story = arg_35_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1081ui_story"]) then
				if arg_35_1.var_.characterEffect1081ui_story and not isNil(arg_35_1.actors_["1081ui_story"]) then
					arg_35_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_0)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1081ui_story"]) and arg_35_1.var_.characterEffect1081ui_story then
				arg_35_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_38_1 = 0
			local var_38_2 = 0.1

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(112062009).content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 4 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 4)

				if (4 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 4)) > 0 and var_38_2 < var_38_5 then
					arg_35_1.talkMaxDuration = var_38_5

					if var_38_5 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + var_38_1
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_6 = math.max(var_38_2, arg_35_1.talkMaxDuration)

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_6 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_1) / var_38_6

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_1 + var_38_6 and arg_35_1.time_ < var_38_1 + var_38_6 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play112062010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 112062010
		arg_39_1.duration_ = 6.93

		local var_39_0 = {
			ja = 5.733,
			ko = 4.3,
			zh = 6.5,
			en = 6.933
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play112062011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_42_0 = arg_39_1.actors_["1081ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1081ui_story == nil then
				arg_39_1.var_.characterEffect1081ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_1 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 and not isNil(var_42_0) then
				if arg_39_1.var_.characterEffect1081ui_story and not isNil(var_42_0) then
					arg_39_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1081ui_story then
				arg_39_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_42_3 = 0
			local var_42_4 = 0.875

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_5 = arg_39_1:GetWordFromCfg(112062010)
				local var_42_6 = arg_39_1:FormatText(var_42_5.content)

				arg_39_1.text_.text = var_42_6

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_8 = 35 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 35)

				if (35 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_6) / 35)) > 0 and var_42_4 < var_42_8 then
					arg_39_1.talkMaxDuration = var_42_8

					if var_42_8 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_3
					end
				end

				arg_39_1.text_.text = var_42_6
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112062", "112062010", "story_v_out_112062.awb") ~= 0 then
					local var_42_9 = manager.audio:GetVoiceLength("story_v_out_112062", "112062010", "story_v_out_112062.awb") / 1000

					if var_42_9 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_3
					end

					if var_42_5.prefab_name ~= "" and arg_39_1.actors_[var_42_5.prefab_name] ~= nil then
						local var_42_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_5.prefab_name].transform, "story_v_out_112062", "112062010", "story_v_out_112062.awb")

						arg_39_1:RecordAudio("112062010", var_42_10)
						arg_39_1:RecordAudio("112062010", var_42_10)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_112062", "112062010", "story_v_out_112062.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_112062", "112062010", "story_v_out_112062.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_11 = math.max(var_42_4, arg_39_1.talkMaxDuration)

			if var_42_3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_3 + var_42_11 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_3) / var_42_11

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_3 + var_42_11 and arg_39_1.time_ < var_42_3 + var_42_11 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play112062011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 112062011
		arg_43_1.duration_ = 6.87

		local var_43_0 = {
			ja = 6.866,
			ko = 6,
			zh = 5.366,
			en = 5.633
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play112062012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_46_0 = 0
			local var_46_1 = 0.75

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(112062011)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 30 <= 0 and var_46_1 or var_46_1 * (utf8.len(var_46_3) / 30)

				if (30 <= 0 and var_46_1 or var_46_1 * (utf8.len(var_46_3) / 30)) > 0 and var_46_1 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112062", "112062011", "story_v_out_112062.awb") ~= 0 then
					local var_46_6 = manager.audio:GetVoiceLength("story_v_out_112062", "112062011", "story_v_out_112062.awb") / 1000

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end

					if var_46_2.prefab_name ~= "" and arg_43_1.actors_[var_46_2.prefab_name] ~= nil then
						local var_46_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_2.prefab_name].transform, "story_v_out_112062", "112062011", "story_v_out_112062.awb")

						arg_43_1:RecordAudio("112062011", var_46_7)
						arg_43_1:RecordAudio("112062011", var_46_7)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_112062", "112062011", "story_v_out_112062.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_112062", "112062011", "story_v_out_112062.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_8 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_8 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_8

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_8 and arg_43_1.time_ < var_46_0 + var_46_8 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play112062012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 112062012
		arg_47_1.duration_ = 10.7

		local var_47_0 = {
			ja = 10.7,
			ko = 7.433,
			zh = 6.666,
			en = 7.033
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play112062013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_50_0 = 0
			local var_50_1 = 0.9

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(112062012)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 34 <= 0 and var_50_1 or var_50_1 * (utf8.len(var_50_3) / 34)

				if (34 <= 0 and var_50_1 or var_50_1 * (utf8.len(var_50_3) / 34)) > 0 and var_50_1 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112062", "112062012", "story_v_out_112062.awb") ~= 0 then
					local var_50_6 = manager.audio:GetVoiceLength("story_v_out_112062", "112062012", "story_v_out_112062.awb") / 1000

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end

					if var_50_2.prefab_name ~= "" and arg_47_1.actors_[var_50_2.prefab_name] ~= nil then
						local var_50_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_2.prefab_name].transform, "story_v_out_112062", "112062012", "story_v_out_112062.awb")

						arg_47_1:RecordAudio("112062012", var_50_7)
						arg_47_1:RecordAudio("112062012", var_50_7)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112062", "112062012", "story_v_out_112062.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112062", "112062012", "story_v_out_112062.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_8 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_8 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_8

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_8 and arg_47_1.time_ < var_50_0 + var_50_8 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play112062013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112062013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play112062014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1081ui_story = arg_51_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1081ui_story"].transform.position).z)
				arg_51_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1081ui_story"].transform.localEulerAngles = arg_51_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1081ui_story"].transform.position).z)
				arg_51_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1081ui_story"].transform.localEulerAngles = arg_51_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_54_1 = 0
			local var_54_2 = 1.075

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(112062013).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 43 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 43)

				if (43 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 43)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play112062014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112062014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play112062015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.2

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(112062014).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 8 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 8)

				if (8 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 8)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play112062015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112062015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
			arg_59_1.auto_ = false
		end

		function arg_59_1.playNext_(arg_61_0)
			arg_59_1.onStoryFinished_()
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.4

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(112062015).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 16 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 16)

				if (16 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 16)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02"
	},
	voices = {
		"story_v_out_112062.awb"
	}
}
