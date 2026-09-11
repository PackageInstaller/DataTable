return {
	Play112221001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112221001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112221002(arg_1_1)
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

			local var_4_5 = 1

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(1, 1, 1)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "1027ui_story"

			if arg_1_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1027ui_story"].transform

			if 1.25 < arg_1_1.time_ and arg_1_1.time_ <= 1.25 + arg_4_0 then
				arg_1_1.var_.moveOldPos1027ui_story = var_4_12.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1027ui_story" .. "Animator"].transform, false)
			end

			local var_4_13 = 0.001

			if 1.25 <= arg_1_1.time_ and arg_1_1.time_ < 1.25 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_1_1.time_ - 1.25) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.25 + var_4_13 and arg_1_1.time_ < 1.25 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.81, -5.8)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if 1.25 < arg_1_1.time_ and arg_1_1.time_ <= 1.25 + arg_4_0 then
				arg_1_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_1")
			end

			local var_4_14 = arg_1_1.actors_["1027ui_story"]

			if 1.25 < arg_1_1.time_ and arg_1_1.time_ <= 1.25 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1027ui_story == nil then
				arg_1_1.var_.characterEffect1027ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 1.25 <= arg_1_1.time_ and arg_1_1.time_ < 1.25 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1027ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.25 + var_4_15 and arg_1_1.time_ < 1.25 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1027ui_story then
				arg_1_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 1.25 < arg_1_1.time_ and arg_1_1.time_ <= 1.25 + arg_4_0 then
				arg_1_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= 1.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= 1.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 1.2
			local var_4_23 = 0.1

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(112221001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 4 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 4)

				if (4 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 4)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221001", "story_v_out_112221.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_112221", "112221001", "story_v_out_112221.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_112221", "112221001", "story_v_out_112221.awb")

						arg_1_1:RecordAudio("112221001", var_4_30)
						arg_1_1:RecordAudio("112221001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_112221", "112221001", "story_v_out_112221.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_112221", "112221001", "story_v_out_112221.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.25,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play112221002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112221002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play112221003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1027ui_story"]) and arg_8_1.var_.characterEffect1027ui_story == nil then
				arg_8_1.var_.characterEffect1027ui_story = arg_8_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1027ui_story"]) then
				if arg_8_1.var_.characterEffect1027ui_story and not isNil(arg_8_1.actors_["1027ui_story"]) then
					arg_8_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1027ui_story"]) and arg_8_1.var_.characterEffect1027ui_story then
				arg_8_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_11_1 = 0
			local var_11_2 = 1.225

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(112221002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 49 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 49)

				if (49 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 49)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play112221003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 112221003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play112221004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_15_0 = 0
			local var_15_1 = 0.175

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_2 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(112221003).content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 7 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_2) / 7)

				if (7 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_2) / 7)) > 0 and var_15_1 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_5 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_5 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_5

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_5 and arg_12_1.time_ < var_15_0 + var_15_5 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play112221004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 112221004
		arg_16_1.duration_ = 7.87

		local var_16_0 = {
			ja = 7.866,
			ko = 5.7,
			zh = 4.533,
			en = 6.033
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play112221005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1027ui_story = arg_16_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1027ui_story"].transform.position).z)
				arg_16_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1027ui_story"].transform.localEulerAngles = arg_16_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_16_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1027ui_story"].transform.position).z)
				arg_16_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1027ui_story"].transform.localEulerAngles = arg_16_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_19_1 = "1148ui_story"

			if arg_16_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_16_1.stage_.transform)

				var_19_2.name = var_19_1
				var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_[var_19_1] = var_19_2

				local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

				var_19_3.enabled = true

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_3.transform, false)

				arg_16_1.var_[var_19_1 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_[var_19_1 .. "Animator"].applyRootMotion = true
				arg_16_1.var_[var_19_1 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_5 = arg_16_1.actors_["1148ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1148ui_story = var_19_5.localPosition

				arg_16_1:ShowWeapon(arg_16_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_19_6 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 then
				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_16_1.time_ - 0) / var_19_6)
				var_19_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_5.position).x, (manager.ui.mainCamera.transform.position - var_19_5.position).y, (manager.ui.mainCamera.transform.position - var_19_5.position).z)
				var_19_5.localEulerAngles.z = 0
				var_19_5.localEulerAngles.x = 0
				var_19_5.localEulerAngles = var_19_5.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_19_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_5.position).x, (manager.ui.mainCamera.transform.position - var_19_5.position).y, (manager.ui.mainCamera.transform.position - var_19_5.position).z)
				var_19_5.localEulerAngles.z = 0
				var_19_5.localEulerAngles.x = 0
				var_19_5.localEulerAngles = var_19_5.localEulerAngles
			end

			local var_19_7 = arg_16_1.actors_["1148ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect1148ui_story == nil then
				arg_16_1.var_.characterEffect1148ui_story = var_19_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 and not isNil(var_19_7) then
				if arg_16_1.var_.characterEffect1148ui_story and not isNil(var_19_7) then
					arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect1148ui_story then
				arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_19_10 = 0
			local var_19_11 = 0.55

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_12 = arg_16_1:GetWordFromCfg(112221004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 22 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 22)

				if (22 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 22)) > 0 and var_19_11 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221004", "story_v_out_112221.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_112221", "112221004", "story_v_out_112221.awb") / 1000

					if var_19_16 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_10
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_112221", "112221004", "story_v_out_112221.awb")

						arg_16_1:RecordAudio("112221004", var_19_17)
						arg_16_1:RecordAudio("112221004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_112221", "112221004", "story_v_out_112221.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_112221", "112221004", "story_v_out_112221.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_18 and arg_16_1.time_ < var_19_10 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play112221005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 112221005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play112221006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1148ui_story"]) and arg_20_1.var_.characterEffect1148ui_story == nil then
				arg_20_1.var_.characterEffect1148ui_story = arg_20_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1148ui_story"]) then
				if arg_20_1.var_.characterEffect1148ui_story and not isNil(arg_20_1.actors_["1148ui_story"]) then
					arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1148ui_story"]) and arg_20_1.var_.characterEffect1148ui_story then
				arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_23_1 = 0
			local var_23_2 = 0.525

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(112221005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 21 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 21)

				if (21 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 21)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play112221006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 112221006
		arg_24_1.duration_ = 3.97

		local var_24_0 = {
			ja = 3.966,
			ko = 3.5,
			zh = 2.866,
			en = 3.966
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play112221007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1148ui_story"]) and arg_24_1.var_.characterEffect1148ui_story == nil then
				arg_24_1.var_.characterEffect1148ui_story = arg_24_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1148ui_story"]) then
				if arg_24_1.var_.characterEffect1148ui_story and not isNil(arg_24_1.actors_["1148ui_story"]) then
					arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1148ui_story"]) and arg_24_1.var_.characterEffect1148ui_story then
				arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_27_2 = 0
			local var_27_3 = 0.275

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(112221006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 11 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 11)

				if (11 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 11)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221006", "story_v_out_112221.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221006", "story_v_out_112221.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_112221", "112221006", "story_v_out_112221.awb")

						arg_24_1:RecordAudio("112221006", var_27_9)
						arg_24_1:RecordAudio("112221006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_112221", "112221006", "story_v_out_112221.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_112221", "112221006", "story_v_out_112221.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_10 and arg_24_1.time_ < var_27_2 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play112221007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 112221007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play112221008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1148ui_story"]) and arg_28_1.var_.characterEffect1148ui_story == nil then
				arg_28_1.var_.characterEffect1148ui_story = arg_28_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1148ui_story"]) then
				if arg_28_1.var_.characterEffect1148ui_story and not isNil(arg_28_1.actors_["1148ui_story"]) then
					arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1148ui_story"]) and arg_28_1.var_.characterEffect1148ui_story then
				arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.125

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(112221007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 5 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 5)

				if (5 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 5)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play112221008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 112221008
		arg_32_1.duration_ = 7.97

		local var_32_0 = {
			ja = 7.966,
			ko = 5.633,
			zh = 4.566,
			en = 6.5
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play112221009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1148ui_story"]) and arg_32_1.var_.characterEffect1148ui_story == nil then
				arg_32_1.var_.characterEffect1148ui_story = arg_32_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1148ui_story"]) then
				if arg_32_1.var_.characterEffect1148ui_story and not isNil(arg_32_1.actors_["1148ui_story"]) then
					arg_32_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1148ui_story"]) and arg_32_1.var_.characterEffect1148ui_story then
				arg_32_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action474")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_35_2 = 0
			local var_35_3 = 0.525

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(112221008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 21 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 21)

				if (21 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 21)) > 0 and var_35_3 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221008", "story_v_out_112221.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221008", "story_v_out_112221.awb") / 1000

					if var_35_8 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_2
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_112221", "112221008", "story_v_out_112221.awb")

						arg_32_1:RecordAudio("112221008", var_35_9)
						arg_32_1:RecordAudio("112221008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_112221", "112221008", "story_v_out_112221.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_112221", "112221008", "story_v_out_112221.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_10 and arg_32_1.time_ < var_35_2 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play112221009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 112221009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play112221010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1148ui_story"]) and arg_36_1.var_.characterEffect1148ui_story == nil then
				arg_36_1.var_.characterEffect1148ui_story = arg_36_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1148ui_story"]) then
				if arg_36_1.var_.characterEffect1148ui_story and not isNil(arg_36_1.actors_["1148ui_story"]) then
					arg_36_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1148ui_story"]) and arg_36_1.var_.characterEffect1148ui_story then
				arg_36_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 0.1

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(112221009).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 4 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 4)

				if (4 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 4)) > 0 and var_39_2 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_6 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_6 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_6

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_6 and arg_36_1.time_ < var_39_1 + var_39_6 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play112221010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 112221010
		arg_40_1.duration_ = 7.97

		local var_40_0 = {
			ja = 6.4,
			ko = 6.6,
			zh = 5,
			en = 7.966
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play112221011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1148ui_story"]) and arg_40_1.var_.characterEffect1148ui_story == nil then
				arg_40_1.var_.characterEffect1148ui_story = arg_40_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1148ui_story"]) then
				if arg_40_1.var_.characterEffect1148ui_story and not isNil(arg_40_1.actors_["1148ui_story"]) then
					arg_40_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1148ui_story"]) and arg_40_1.var_.characterEffect1148ui_story then
				arg_40_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_43_2 = 0
			local var_43_3 = 0.675

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:GetWordFromCfg(112221010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 27 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 27)

				if (27 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 27)) > 0 and var_43_3 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221010", "story_v_out_112221.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221010", "story_v_out_112221.awb") / 1000

					if var_43_8 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_2
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_112221", "112221010", "story_v_out_112221.awb")

						arg_40_1:RecordAudio("112221010", var_43_9)
						arg_40_1:RecordAudio("112221010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_112221", "112221010", "story_v_out_112221.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_112221", "112221010", "story_v_out_112221.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_10 and arg_40_1.time_ < var_43_2 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play112221011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 112221011
		arg_44_1.duration_ = 14.27

		local var_44_0 = {
			ja = 10.866,
			ko = 10.766,
			zh = 9.633,
			en = 14.266
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play112221012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_47_0 = 0
			local var_47_1 = 1.325

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(112221011)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 53 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 53)

				if (53 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 53)) > 0 and var_47_1 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221011", "story_v_out_112221.awb") ~= 0 then
					local var_47_6 = manager.audio:GetVoiceLength("story_v_out_112221", "112221011", "story_v_out_112221.awb") / 1000

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end

					if var_47_2.prefab_name ~= "" and arg_44_1.actors_[var_47_2.prefab_name] ~= nil then
						local var_47_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_2.prefab_name].transform, "story_v_out_112221", "112221011", "story_v_out_112221.awb")

						arg_44_1:RecordAudio("112221011", var_47_7)
						arg_44_1:RecordAudio("112221011", var_47_7)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_112221", "112221011", "story_v_out_112221.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_112221", "112221011", "story_v_out_112221.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play112221012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 112221012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play112221013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1148ui_story"]) and arg_48_1.var_.characterEffect1148ui_story == nil then
				arg_48_1.var_.characterEffect1148ui_story = arg_48_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1148ui_story"]) then
				if arg_48_1.var_.characterEffect1148ui_story and not isNil(arg_48_1.actors_["1148ui_story"]) then
					arg_48_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1148ui_story"]) and arg_48_1.var_.characterEffect1148ui_story then
				arg_48_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 0.475

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(112221012).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 19 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 19)

				if (19 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 19)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play112221013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 112221013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play112221014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.525

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(112221013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 21 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 21)

				if (21 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 21)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play112221014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 112221014
		arg_56_1.duration_ = 2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play112221015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1148ui_story"]) and arg_56_1.var_.characterEffect1148ui_story == nil then
				arg_56_1.var_.characterEffect1148ui_story = arg_56_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1148ui_story"]) then
				if arg_56_1.var_.characterEffect1148ui_story and not isNil(arg_56_1.actors_["1148ui_story"]) then
					arg_56_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1148ui_story"]) and arg_56_1.var_.characterEffect1148ui_story then
				arg_56_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_59_2 = 0
			local var_59_3 = 0.05

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(112221014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 2 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 2)

				if (2 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 2)) > 0 and var_59_3 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221014", "story_v_out_112221.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221014", "story_v_out_112221.awb") / 1000

					if var_59_8 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_2
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_out_112221", "112221014", "story_v_out_112221.awb")

						arg_56_1:RecordAudio("112221014", var_59_9)
						arg_56_1:RecordAudio("112221014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_112221", "112221014", "story_v_out_112221.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_112221", "112221014", "story_v_out_112221.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_10 and arg_56_1.time_ < var_59_2 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play112221015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 112221015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play112221016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1027ui_story = arg_60_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1027ui_story"].transform.position).z)
				arg_60_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1027ui_story"].transform.localEulerAngles = arg_60_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1027ui_story"].transform.position).z)
				arg_60_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1027ui_story"].transform.localEulerAngles = arg_60_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["1148ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1148ui_story = var_63_1.localPosition
			end

			local var_63_2 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 then
				var_63_1.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_2)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 then
				var_63_1.localPosition = Vector3.New(0, 100, 0)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			local var_63_3 = 0
			local var_63_4 = 0.825

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_3 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_5 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(112221015).content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 33 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_5) / 33)

				if (33 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_5) / 33)) > 0 and var_63_4 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_3 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_3
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_4, arg_60_1.talkMaxDuration)

			if var_63_3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_3 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_3) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_3 + var_63_8 and arg_60_1.time_ < var_63_3 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play112221016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 112221016
		arg_64_1.duration_ = 5.13

		local var_64_0 = {
			ja = 5.133,
			ko = 5,
			zh = 4,
			en = 4.4
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play112221017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if arg_64_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_67_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_64_1.stage_.transform)

				var_67_0.name = "1084ui_story"
				var_67_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1084ui_story"] = var_67_0

				local var_67_1 = var_67_0:GetComponentInChildren(typeof(CharacterEffect))

				var_67_1.enabled = true

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end

				arg_64_1:ShowWeapon(var_67_1.transform, false)

				arg_64_1.var_["1084ui_story" .. "Animator"] = var_67_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_64_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_64_1.var_["1084ui_story" .. "LipSync"] = var_67_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_67_3 = arg_64_1.actors_["1084ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_3.localPosition

				arg_64_1:ShowWeapon(arg_64_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_67_4 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				var_67_3.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_64_1.time_ - 0) / var_67_4)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				var_67_3.localPosition = Vector3.New(0, -0.97, -6)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles
			end

			local var_67_5 = arg_64_1.actors_["1084ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_5) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_6 and not isNil(var_67_5) then
				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_5) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_6 and arg_64_1.time_ < 0 + var_67_6 + arg_67_0 and not isNil(var_67_5) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_67_8 = 0
			local var_67_9 = 0.325

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_10 = arg_64_1:GetWordFromCfg(112221016)
				local var_67_11 = arg_64_1:FormatText(var_67_10.content)

				arg_64_1.text_.text = var_67_11

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_13 = 13 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_11) / 13)

				if (13 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_11) / 13)) > 0 and var_67_9 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_8
					end
				end

				arg_64_1.text_.text = var_67_11
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221016", "story_v_out_112221.awb") ~= 0 then
					local var_67_14 = manager.audio:GetVoiceLength("story_v_out_112221", "112221016", "story_v_out_112221.awb") / 1000

					if var_67_14 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_8
					end

					if var_67_10.prefab_name ~= "" and arg_64_1.actors_[var_67_10.prefab_name] ~= nil then
						local var_67_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_10.prefab_name].transform, "story_v_out_112221", "112221016", "story_v_out_112221.awb")

						arg_64_1:RecordAudio("112221016", var_67_15)
						arg_64_1:RecordAudio("112221016", var_67_15)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_112221", "112221016", "story_v_out_112221.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_112221", "112221016", "story_v_out_112221.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_16 = math.max(var_67_9, arg_64_1.talkMaxDuration)

			if var_67_8 <= arg_64_1.time_ and arg_64_1.time_ < var_67_8 + var_67_16 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_8) / var_67_16

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_8 + var_67_16 and arg_64_1.time_ < var_67_8 + var_67_16 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play112221017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 112221017
		arg_68_1.duration_ = 8.13

		local var_68_0 = {
			ja = 8.133,
			ko = 6.3,
			zh = 5.833,
			en = 7.866
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play112221018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = arg_68_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).z)
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles = arg_68_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).z)
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles = arg_68_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_71_1 = "1039ui_story"

			if arg_68_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_71_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_68_1.stage_.transform)

				var_71_2.name = var_71_1
				var_71_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_[var_71_1] = var_71_2

				local var_71_3 = var_71_2:GetComponentInChildren(typeof(CharacterEffect))

				var_71_3.enabled = true

				local var_71_4 = GameObjectTools.GetOrAddComponent(var_71_2, typeof(DynamicBoneHelper))

				if var_71_4 then
					var_71_4:EnableDynamicBone(false)
				end

				arg_68_1:ShowWeapon(var_71_3.transform, false)

				arg_68_1.var_[var_71_1 .. "Animator"] = var_71_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_68_1.var_[var_71_1 .. "Animator"].applyRootMotion = true
				arg_68_1.var_[var_71_1 .. "LipSync"] = var_71_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_71_5 = arg_68_1.actors_["1039ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1039ui_story = var_71_5.localPosition

				arg_68_1:ShowWeapon(arg_68_1.var_["1039ui_story" .. "Animator"].transform, false)
			end

			local var_71_6 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_6 then
				var_71_5.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_68_1.time_ - 0) / var_71_6)
				var_71_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_5.position).x, (manager.ui.mainCamera.transform.position - var_71_5.position).y, (manager.ui.mainCamera.transform.position - var_71_5.position).z)
				var_71_5.localEulerAngles.z = 0
				var_71_5.localEulerAngles.x = 0
				var_71_5.localEulerAngles = var_71_5.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_6 and arg_68_1.time_ < 0 + var_71_6 + arg_71_0 then
				var_71_5.localPosition = Vector3.New(0, -1.01, -5.9)
				var_71_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_5.position).x, (manager.ui.mainCamera.transform.position - var_71_5.position).y, (manager.ui.mainCamera.transform.position - var_71_5.position).z)
				var_71_5.localEulerAngles.z = 0
				var_71_5.localEulerAngles.x = 0
				var_71_5.localEulerAngles = var_71_5.localEulerAngles
			end

			local var_71_7 = arg_68_1.actors_["1039ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_7) and arg_68_1.var_.characterEffect1039ui_story == nil then
				arg_68_1.var_.characterEffect1039ui_story = var_71_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_8 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_8 and not isNil(var_71_7) then
				if arg_68_1.var_.characterEffect1039ui_story and not isNil(var_71_7) then
					arg_68_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_8 and arg_68_1.time_ < 0 + var_71_8 + arg_71_0 and not isNil(var_71_7) and arg_68_1.var_.characterEffect1039ui_story then
				arg_68_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_71_10 = 0
			local var_71_11 = 0.65

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_12 = arg_68_1:GetWordFromCfg(112221017)
				local var_71_13 = arg_68_1:FormatText(var_71_12.content)

				arg_68_1.text_.text = var_71_13

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_15 = 26 <= 0 and var_71_11 or var_71_11 * (utf8.len(var_71_13) / 26)

				if (26 <= 0 and var_71_11 or var_71_11 * (utf8.len(var_71_13) / 26)) > 0 and var_71_11 < var_71_15 then
					arg_68_1.talkMaxDuration = var_71_15

					if var_71_15 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_15 + var_71_10
					end
				end

				arg_68_1.text_.text = var_71_13
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221017", "story_v_out_112221.awb") ~= 0 then
					local var_71_16 = manager.audio:GetVoiceLength("story_v_out_112221", "112221017", "story_v_out_112221.awb") / 1000

					if var_71_16 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_16 + var_71_10
					end

					if var_71_12.prefab_name ~= "" and arg_68_1.actors_[var_71_12.prefab_name] ~= nil then
						local var_71_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_12.prefab_name].transform, "story_v_out_112221", "112221017", "story_v_out_112221.awb")

						arg_68_1:RecordAudio("112221017", var_71_17)
						arg_68_1:RecordAudio("112221017", var_71_17)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_112221", "112221017", "story_v_out_112221.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_112221", "112221017", "story_v_out_112221.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_18 = math.max(var_71_11, arg_68_1.talkMaxDuration)

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_18 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_10) / var_71_18

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_10 + var_71_18 and arg_68_1.time_ < var_71_10 + var_71_18 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_68_1:InitPlayNodeList()
	end,
	Play112221018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 112221018
		arg_72_1.duration_ = 8.4

		local var_72_0 = {
			ja = 7.4,
			ko = 7.933,
			zh = 8.4,
			en = 7.633
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play112221019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1039ui_story = arg_72_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1039ui_story"].transform.position).z)
				arg_72_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1039ui_story"].transform.localEulerAngles = arg_72_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1039ui_story"].transform.position).z)
				arg_72_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1039ui_story"].transform.localEulerAngles = arg_72_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_75_1 = arg_72_1.actors_["1148ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1148ui_story = var_75_1.localPosition
			end

			local var_75_2 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 then
				var_75_1.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_72_1.time_ - 0) / var_75_2)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 then
				var_75_1.localPosition = Vector3.New(0, -0.8, -6.2)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_75_3 = arg_72_1.actors_["1148ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1148ui_story == nil then
				arg_72_1.var_.characterEffect1148ui_story = var_75_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_4 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 and not isNil(var_75_3) then
				if arg_72_1.var_.characterEffect1148ui_story and not isNil(var_75_3) then
					arg_72_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1148ui_story then
				arg_72_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_75_6 = 0
			local var_75_7 = 1.025

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(112221018)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 41 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 41)

				if (41 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 41)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221018", "story_v_out_112221.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_112221", "112221018", "story_v_out_112221.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_112221", "112221018", "story_v_out_112221.awb")

						arg_72_1:RecordAudio("112221018", var_75_13)
						arg_72_1:RecordAudio("112221018", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_112221", "112221018", "story_v_out_112221.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_112221", "112221018", "story_v_out_112221.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play112221019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 112221019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play112221020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1148ui_story = arg_76_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1148ui_story"].transform.position).z)
				arg_76_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1148ui_story"].transform.localEulerAngles = arg_76_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1148ui_story"].transform.position).z)
				arg_76_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1148ui_story"].transform.localEulerAngles = arg_76_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1027ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1027ui_story = var_79_1.localPosition
			end

			local var_79_2 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 then
				var_79_1.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_76_1.time_ - 0) / var_79_2)
				var_79_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_1.position).x, (manager.ui.mainCamera.transform.position - var_79_1.position).y, (manager.ui.mainCamera.transform.position - var_79_1.position).z)
				var_79_1.localEulerAngles.z = 0
				var_79_1.localEulerAngles.x = 0
				var_79_1.localEulerAngles = var_79_1.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 then
				var_79_1.localPosition = Vector3.New(0, -0.81, -5.8)
				var_79_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_1.position).x, (manager.ui.mainCamera.transform.position - var_79_1.position).y, (manager.ui.mainCamera.transform.position - var_79_1.position).z)
				var_79_1.localEulerAngles.z = 0
				var_79_1.localEulerAngles.x = 0
				var_79_1.localEulerAngles = var_79_1.localEulerAngles
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action8_2")
			end

			local var_79_3 = 0
			local var_79_4 = 0.625

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_5 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(112221019).content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 25 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_5) / 25)

				if (25 <= 0 and var_79_4 or var_79_4 * (utf8.len(var_79_5) / 25)) > 0 and var_79_4 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_3 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_3
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_4, arg_76_1.talkMaxDuration)

			if var_79_3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_3 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_3) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_3 + var_79_8 and arg_76_1.time_ < var_79_3 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play112221020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 112221020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play112221021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.175

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(112221020).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 7 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 7)

				if (7 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 7)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play112221021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 112221021
		arg_84_1.duration_ = 1.83

		local var_84_0 = {
			ja = 1.733,
			ko = 1.1,
			zh = 1.8,
			en = 1.833
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play112221022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.1

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:GetWordFromCfg(112221021)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 4 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 4)

				if (4 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 4)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221021", "story_v_out_112221.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_112221", "112221021", "story_v_out_112221.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_112221", "112221021", "story_v_out_112221.awb")

						arg_84_1:RecordAudio("112221021", var_87_6)
						arg_84_1:RecordAudio("112221021", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_112221", "112221021", "story_v_out_112221.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_112221", "112221021", "story_v_out_112221.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play112221022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 112221022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play112221023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.25

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(112221022).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 50 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 50)

				if (50 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 50)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play112221023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 112221023
		arg_92_1.duration_ = 7.3

		local var_92_0 = {
			ja = 6.266,
			ko = 7.3,
			zh = 5.5,
			en = 4.7
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play112221024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.675

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(112221023)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 27 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 27)

				if (27 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 27)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221023", "story_v_out_112221.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_112221", "112221023", "story_v_out_112221.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_112221", "112221023", "story_v_out_112221.awb")

						arg_92_1:RecordAudio("112221023", var_95_6)
						arg_92_1:RecordAudio("112221023", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_112221", "112221023", "story_v_out_112221.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_112221", "112221023", "story_v_out_112221.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play112221024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 112221024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play112221025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1027ui_story = arg_96_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1027ui_story"].transform.position).z)
				arg_96_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1027ui_story"].transform.localEulerAngles = arg_96_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1027ui_story"].transform.position).z)
				arg_96_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1027ui_story"].transform.localEulerAngles = arg_96_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_99_1 = 0
			local var_99_2 = 0.375

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(112221024).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 15 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 15)

				if (15 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 15)) > 0 and var_99_2 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_6 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_6 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_6

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_6 and arg_96_1.time_ < var_99_1 + var_99_6 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play112221025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 112221025
		arg_100_1.duration_ = 6.47

		local var_100_0 = {
			ja = 5.166,
			ko = 4.366,
			zh = 4.5,
			en = 6.466
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play112221026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1148ui_story = arg_100_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1148ui_story"].transform.position).z)
				arg_100_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1148ui_story"].transform.localEulerAngles = arg_100_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_100_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1148ui_story"].transform.position).z)
				arg_100_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1148ui_story"].transform.localEulerAngles = arg_100_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["1148ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1148ui_story == nil then
				arg_100_1.var_.characterEffect1148ui_story = var_103_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 and not isNil(var_103_1) then
				if arg_100_1.var_.characterEffect1148ui_story and not isNil(var_103_1) then
					arg_100_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1148ui_story then
				arg_100_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_103_4 = 0
			local var_103_5 = 0.5

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(112221025)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 20 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 20)

				if (20 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 20)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221025", "story_v_out_112221.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_112221", "112221025", "story_v_out_112221.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_112221", "112221025", "story_v_out_112221.awb")

						arg_100_1:RecordAudio("112221025", var_103_11)
						arg_100_1:RecordAudio("112221025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_112221", "112221025", "story_v_out_112221.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_112221", "112221025", "story_v_out_112221.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play112221026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 112221026
		arg_104_1.duration_ = 5.53

		local var_104_0 = {
			ja = 4.566,
			ko = 4.166,
			zh = 4.4,
			en = 5.533
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play112221027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_107_0 = 0
			local var_107_1 = 0.55

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(112221026)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 22 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 22)

				if (22 <= 0 and var_107_1 or var_107_1 * (utf8.len(var_107_3) / 22)) > 0 and var_107_1 < var_107_5 then
					arg_104_1.talkMaxDuration = var_107_5

					if var_107_5 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221026", "story_v_out_112221.awb") ~= 0 then
					local var_107_6 = manager.audio:GetVoiceLength("story_v_out_112221", "112221026", "story_v_out_112221.awb") / 1000

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end

					if var_107_2.prefab_name ~= "" and arg_104_1.actors_[var_107_2.prefab_name] ~= nil then
						local var_107_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_2.prefab_name].transform, "story_v_out_112221", "112221026", "story_v_out_112221.awb")

						arg_104_1:RecordAudio("112221026", var_107_7)
						arg_104_1:RecordAudio("112221026", var_107_7)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_112221", "112221026", "story_v_out_112221.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_112221", "112221026", "story_v_out_112221.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_8 and arg_104_1.time_ < var_107_0 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play112221027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 112221027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play112221028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) and arg_108_1.var_.characterEffect1148ui_story == nil then
				arg_108_1.var_.characterEffect1148ui_story = arg_108_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) then
				if arg_108_1.var_.characterEffect1148ui_story and not isNil(arg_108_1.actors_["1148ui_story"]) then
					arg_108_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) and arg_108_1.var_.characterEffect1148ui_story then
				arg_108_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.8

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(112221027).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 32 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 32)

				if (32 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 32)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play112221028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 112221028
		arg_112_1.duration_ = 12.6

		local var_112_0 = {
			ja = 9.2,
			ko = 8.433,
			zh = 8.033,
			en = 12.6
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play112221029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1148ui_story"]) and arg_112_1.var_.characterEffect1148ui_story == nil then
				arg_112_1.var_.characterEffect1148ui_story = arg_112_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1148ui_story"]) then
				if arg_112_1.var_.characterEffect1148ui_story and not isNil(arg_112_1.actors_["1148ui_story"]) then
					arg_112_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1148ui_story"]) and arg_112_1.var_.characterEffect1148ui_story then
				arg_112_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_115_2 = 0
			local var_115_3 = 0.75

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(112221028)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 30 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 30)

				if (30 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 30)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221028", "story_v_out_112221.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221028", "story_v_out_112221.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_112221", "112221028", "story_v_out_112221.awb")

						arg_112_1:RecordAudio("112221028", var_115_9)
						arg_112_1:RecordAudio("112221028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_112221", "112221028", "story_v_out_112221.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_112221", "112221028", "story_v_out_112221.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play112221029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 112221029
		arg_116_1.duration_ = 7.53

		local var_116_0 = {
			ja = 7.2,
			ko = 7.533,
			zh = 6.6,
			en = 7.166
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play112221030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1148ui_story = arg_116_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1148ui_story"].transform.position).z)
				arg_116_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1148ui_story"].transform.localEulerAngles = arg_116_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1148ui_story"].transform.position).z)
				arg_116_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1148ui_story"].transform.localEulerAngles = arg_116_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["1084ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1084ui_story = var_119_1.localPosition
			end

			local var_119_2 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 then
				var_119_1.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_116_1.time_ - 0) / var_119_2)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 then
				var_119_1.localPosition = Vector3.New(0, -0.97, -6)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles
			end

			local var_119_3 = arg_116_1.actors_["1084ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = var_119_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 and not isNil(var_119_3) then
				if arg_116_1.var_.characterEffect1084ui_story and not isNil(var_119_3) then
					arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect1084ui_story then
				arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_119_6 = 0
			local var_119_7 = 0.925

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_8 = arg_116_1:GetWordFromCfg(112221029)
				local var_119_9 = arg_116_1:FormatText(var_119_8.content)

				arg_116_1.text_.text = var_119_9

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 37 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_9) / 37)

				if (37 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_9) / 37)) > 0 and var_119_7 < var_119_11 then
					arg_116_1.talkMaxDuration = var_119_11

					if var_119_11 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_11 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_9
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221029", "story_v_out_112221.awb") ~= 0 then
					local var_119_12 = manager.audio:GetVoiceLength("story_v_out_112221", "112221029", "story_v_out_112221.awb") / 1000

					if var_119_12 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_12 + var_119_6
					end

					if var_119_8.prefab_name ~= "" and arg_116_1.actors_[var_119_8.prefab_name] ~= nil then
						local var_119_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_8.prefab_name].transform, "story_v_out_112221", "112221029", "story_v_out_112221.awb")

						arg_116_1:RecordAudio("112221029", var_119_13)
						arg_116_1:RecordAudio("112221029", var_119_13)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_112221", "112221029", "story_v_out_112221.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_112221", "112221029", "story_v_out_112221.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_14 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_14 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_14

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_14 and arg_116_1.time_ < var_119_6 + var_119_14 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play112221030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 112221030
		arg_120_1.duration_ = 13.77

		local var_120_0 = {
			ja = 13.766,
			ko = 8.6,
			zh = 8.566,
			en = 12.4
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play112221031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_123_0 = 0
			local var_123_1 = 0.975

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_2 = arg_120_1:GetWordFromCfg(112221030)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 39 <= 0 and var_123_1 or var_123_1 * (utf8.len(var_123_3) / 39)

				if (39 <= 0 and var_123_1 or var_123_1 * (utf8.len(var_123_3) / 39)) > 0 and var_123_1 < var_123_5 then
					arg_120_1.talkMaxDuration = var_123_5

					if var_123_5 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221030", "story_v_out_112221.awb") ~= 0 then
					local var_123_6 = manager.audio:GetVoiceLength("story_v_out_112221", "112221030", "story_v_out_112221.awb") / 1000

					if var_123_6 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_0
					end

					if var_123_2.prefab_name ~= "" and arg_120_1.actors_[var_123_2.prefab_name] ~= nil then
						local var_123_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_2.prefab_name].transform, "story_v_out_112221", "112221030", "story_v_out_112221.awb")

						arg_120_1:RecordAudio("112221030", var_123_7)
						arg_120_1:RecordAudio("112221030", var_123_7)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_112221", "112221030", "story_v_out_112221.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_112221", "112221030", "story_v_out_112221.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_8 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_8 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_8

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_8 and arg_120_1.time_ < var_123_0 + var_123_8 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play112221031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 112221031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play112221032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1084ui_story"]) and arg_124_1.var_.characterEffect1084ui_story == nil then
				arg_124_1.var_.characterEffect1084ui_story = arg_124_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1084ui_story"]) then
				if arg_124_1.var_.characterEffect1084ui_story and not isNil(arg_124_1.actors_["1084ui_story"]) then
					arg_124_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1084ui_story"]) and arg_124_1.var_.characterEffect1084ui_story then
				arg_124_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_127_1 = 0
			local var_127_2 = 0.3

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(112221031).content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 12 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 12)

				if (12 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 12)) > 0 and var_127_2 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_6 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_6 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_6

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_6 and arg_124_1.time_ < var_127_1 + var_127_6 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play112221032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 112221032
		arg_128_1.duration_ = 2.73

		local var_128_0 = {
			ja = 2.733,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.6
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play112221033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) and arg_128_1.var_.characterEffect1084ui_story == nil then
				arg_128_1.var_.characterEffect1084ui_story = arg_128_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) then
				if arg_128_1.var_.characterEffect1084ui_story and not isNil(arg_128_1.actors_["1084ui_story"]) then
					arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1084ui_story"]) and arg_128_1.var_.characterEffect1084ui_story then
				arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_131_2 = 0
			local var_131_3 = 0.125

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_4 = arg_128_1:GetWordFromCfg(112221032)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 5 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 5)

				if (5 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 5)) > 0 and var_131_3 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221032", "story_v_out_112221.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221032", "story_v_out_112221.awb") / 1000

					if var_131_8 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_2
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_out_112221", "112221032", "story_v_out_112221.awb")

						arg_128_1:RecordAudio("112221032", var_131_9)
						arg_128_1:RecordAudio("112221032", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_112221", "112221032", "story_v_out_112221.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_112221", "112221032", "story_v_out_112221.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_3, arg_128_1.talkMaxDuration)

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_2) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_2 + var_131_10 and arg_128_1.time_ < var_131_2 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play112221033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 112221033
		arg_132_1.duration_ = 10.6

		local var_132_0 = {
			ja = 10.6,
			ko = 7.466,
			zh = 7.033,
			en = 8.966
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play112221034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1084ui_story = arg_132_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).z)
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles = arg_132_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1084ui_story"].transform.position).z)
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1084ui_story"].transform.localEulerAngles = arg_132_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_135_1 = "1081ui_story"

			if arg_132_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_135_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_132_1.stage_.transform)

				var_135_2.name = var_135_1
				var_135_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_[var_135_1] = var_135_2

				local var_135_3 = var_135_2:GetComponentInChildren(typeof(CharacterEffect))

				var_135_3.enabled = true

				local var_135_4 = GameObjectTools.GetOrAddComponent(var_135_2, typeof(DynamicBoneHelper))

				if var_135_4 then
					var_135_4:EnableDynamicBone(false)
				end

				arg_132_1:ShowWeapon(var_135_3.transform, false)

				arg_132_1.var_[var_135_1 .. "Animator"] = var_135_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_132_1.var_[var_135_1 .. "Animator"].applyRootMotion = true
				arg_132_1.var_[var_135_1 .. "LipSync"] = var_135_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_135_5 = arg_132_1.actors_["1081ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1081ui_story = var_135_5.localPosition

				arg_132_1:ShowWeapon(arg_132_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_135_6 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_6 then
				var_135_5.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_132_1.time_ - 0) / var_135_6)
				var_135_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_5.position).x, (manager.ui.mainCamera.transform.position - var_135_5.position).y, (manager.ui.mainCamera.transform.position - var_135_5.position).z)
				var_135_5.localEulerAngles.z = 0
				var_135_5.localEulerAngles.x = 0
				var_135_5.localEulerAngles = var_135_5.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_6 and arg_132_1.time_ < 0 + var_135_6 + arg_135_0 then
				var_135_5.localPosition = Vector3.New(0, -0.92, -5.8)
				var_135_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_5.position).x, (manager.ui.mainCamera.transform.position - var_135_5.position).y, (manager.ui.mainCamera.transform.position - var_135_5.position).z)
				var_135_5.localEulerAngles.z = 0
				var_135_5.localEulerAngles.x = 0
				var_135_5.localEulerAngles = var_135_5.localEulerAngles
			end

			local var_135_7 = arg_132_1.actors_["1081ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.characterEffect1081ui_story == nil then
				arg_132_1.var_.characterEffect1081ui_story = var_135_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_8 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_8 and not isNil(var_135_7) then
				if arg_132_1.var_.characterEffect1081ui_story and not isNil(var_135_7) then
					arg_132_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_8 and arg_132_1.time_ < 0 + var_135_8 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.characterEffect1081ui_story then
				arg_132_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_135_10 = 0
			local var_135_11 = 0.95

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_12 = arg_132_1:GetWordFromCfg(112221033)
				local var_135_13 = arg_132_1:FormatText(var_135_12.content)

				arg_132_1.text_.text = var_135_13

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_15 = 38 <= 0 and var_135_11 or var_135_11 * (utf8.len(var_135_13) / 38)

				if (38 <= 0 and var_135_11 or var_135_11 * (utf8.len(var_135_13) / 38)) > 0 and var_135_11 < var_135_15 then
					arg_132_1.talkMaxDuration = var_135_15

					if var_135_15 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_15 + var_135_10
					end
				end

				arg_132_1.text_.text = var_135_13
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221033", "story_v_out_112221.awb") ~= 0 then
					local var_135_16 = manager.audio:GetVoiceLength("story_v_out_112221", "112221033", "story_v_out_112221.awb") / 1000

					if var_135_16 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_16 + var_135_10
					end

					if var_135_12.prefab_name ~= "" and arg_132_1.actors_[var_135_12.prefab_name] ~= nil then
						local var_135_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_12.prefab_name].transform, "story_v_out_112221", "112221033", "story_v_out_112221.awb")

						arg_132_1:RecordAudio("112221033", var_135_17)
						arg_132_1:RecordAudio("112221033", var_135_17)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_112221", "112221033", "story_v_out_112221.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_112221", "112221033", "story_v_out_112221.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_18 = math.max(var_135_11, arg_132_1.talkMaxDuration)

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_18 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_10) / var_135_18

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_10 + var_135_18 and arg_132_1.time_ < var_135_10 + var_135_18 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_132_1:InitPlayNodeList()
	end,
	Play112221034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 112221034
		arg_136_1.duration_ = 6.8

		local var_136_0 = {
			ja = 4.2,
			ko = 4.8,
			zh = 4.8,
			en = 6.8
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play112221035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_139_0 = 0
			local var_139_1 = 0.55

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_2 = arg_136_1:GetWordFromCfg(112221034)
				local var_139_3 = arg_136_1:FormatText(var_139_2.content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 22 <= 0 and var_139_1 or var_139_1 * (utf8.len(var_139_3) / 22)

				if (22 <= 0 and var_139_1 or var_139_1 * (utf8.len(var_139_3) / 22)) > 0 and var_139_1 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221034", "story_v_out_112221.awb") ~= 0 then
					local var_139_6 = manager.audio:GetVoiceLength("story_v_out_112221", "112221034", "story_v_out_112221.awb") / 1000

					if var_139_6 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_0
					end

					if var_139_2.prefab_name ~= "" and arg_136_1.actors_[var_139_2.prefab_name] ~= nil then
						local var_139_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_2.prefab_name].transform, "story_v_out_112221", "112221034", "story_v_out_112221.awb")

						arg_136_1:RecordAudio("112221034", var_139_7)
						arg_136_1:RecordAudio("112221034", var_139_7)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_112221", "112221034", "story_v_out_112221.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_112221", "112221034", "story_v_out_112221.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_8 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_8 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_8

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_8 and arg_136_1.time_ < var_139_0 + var_139_8 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play112221035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 112221035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play112221036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1081ui_story"]) and arg_140_1.var_.characterEffect1081ui_story == nil then
				arg_140_1.var_.characterEffect1081ui_story = arg_140_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1081ui_story"]) then
				if arg_140_1.var_.characterEffect1081ui_story and not isNil(arg_140_1.actors_["1081ui_story"]) then
					arg_140_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1081ui_story"]) and arg_140_1.var_.characterEffect1081ui_story then
				arg_140_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 0.35

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(112221035).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 14 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 14)

				if (14 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 14)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play112221036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 112221036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play112221037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.65

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(112221036).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 26 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 26)

				if (26 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 26)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play112221037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 112221037
		arg_148_1.duration_ = 7.73

		local var_148_0 = {
			ja = 4.433,
			ko = 2.366,
			zh = 3.133,
			en = 7.733
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play112221038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1081ui_story"]) and arg_148_1.var_.characterEffect1081ui_story == nil then
				arg_148_1.var_.characterEffect1081ui_story = arg_148_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1081ui_story"]) then
				if arg_148_1.var_.characterEffect1081ui_story and not isNil(arg_148_1.actors_["1081ui_story"]) then
					arg_148_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1081ui_story"]) and arg_148_1.var_.characterEffect1081ui_story then
				arg_148_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action457")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_151_2 = 0
			local var_151_3 = 0.3

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_4 = arg_148_1:GetWordFromCfg(112221037)
				local var_151_5 = arg_148_1:FormatText(var_151_4.content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 12 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_5) / 12)

				if (12 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_5) / 12)) > 0 and var_151_3 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_2
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221037", "story_v_out_112221.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221037", "story_v_out_112221.awb") / 1000

					if var_151_8 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_2
					end

					if var_151_4.prefab_name ~= "" and arg_148_1.actors_[var_151_4.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_4.prefab_name].transform, "story_v_out_112221", "112221037", "story_v_out_112221.awb")

						arg_148_1:RecordAudio("112221037", var_151_9)
						arg_148_1:RecordAudio("112221037", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_112221", "112221037", "story_v_out_112221.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_112221", "112221037", "story_v_out_112221.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_3, arg_148_1.talkMaxDuration)

			if var_151_2 <= arg_148_1.time_ and arg_148_1.time_ < var_151_2 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_2) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_2 + var_151_10 and arg_148_1.time_ < var_151_2 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play112221038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 112221038
		arg_152_1.duration_ = 7.7

		local var_152_0 = {
			ja = 7.7,
			ko = 5.5,
			zh = 6.833,
			en = 7.666
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play112221039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action476")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_155_0 = 0
			local var_155_1 = 0.775

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_2 = arg_152_1:GetWordFromCfg(112221038)
				local var_155_3 = arg_152_1:FormatText(var_155_2.content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 31 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 31)

				if (31 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 31)) > 0 and var_155_1 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221038", "story_v_out_112221.awb") ~= 0 then
					local var_155_6 = manager.audio:GetVoiceLength("story_v_out_112221", "112221038", "story_v_out_112221.awb") / 1000

					if var_155_6 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_0
					end

					if var_155_2.prefab_name ~= "" and arg_152_1.actors_[var_155_2.prefab_name] ~= nil then
						local var_155_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_2.prefab_name].transform, "story_v_out_112221", "112221038", "story_v_out_112221.awb")

						arg_152_1:RecordAudio("112221038", var_155_7)
						arg_152_1:RecordAudio("112221038", var_155_7)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_112221", "112221038", "story_v_out_112221.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_112221", "112221038", "story_v_out_112221.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_8 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_8 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_8

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_8 and arg_152_1.time_ < var_155_0 + var_155_8 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play112221039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 112221039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play112221040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1081ui_story"]) and arg_156_1.var_.characterEffect1081ui_story == nil then
				arg_156_1.var_.characterEffect1081ui_story = arg_156_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1081ui_story"]) then
				if arg_156_1.var_.characterEffect1081ui_story and not isNil(arg_156_1.actors_["1081ui_story"]) then
					arg_156_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1081ui_story"]) and arg_156_1.var_.characterEffect1081ui_story then
				arg_156_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.4

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(112221039).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 16 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 16)

				if (16 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 16)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play112221040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 112221040
		arg_160_1.duration_ = 4.57

		local var_160_0 = {
			ja = 4.566,
			ko = 2.2,
			zh = 2.033,
			en = 2.933
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play112221041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1081ui_story"]) and arg_160_1.var_.characterEffect1081ui_story == nil then
				arg_160_1.var_.characterEffect1081ui_story = arg_160_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1081ui_story"]) then
				if arg_160_1.var_.characterEffect1081ui_story and not isNil(arg_160_1.actors_["1081ui_story"]) then
					arg_160_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1081ui_story"]) and arg_160_1.var_.characterEffect1081ui_story then
				arg_160_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action464")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_163_2 = 0
			local var_163_3 = 0.2

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_4 = arg_160_1:GetWordFromCfg(112221040)
				local var_163_5 = arg_160_1:FormatText(var_163_4.content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 8 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 8)

				if (8 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 8)) > 0 and var_163_3 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221040", "story_v_out_112221.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221040", "story_v_out_112221.awb") / 1000

					if var_163_8 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_2
					end

					if var_163_4.prefab_name ~= "" and arg_160_1.actors_[var_163_4.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_4.prefab_name].transform, "story_v_out_112221", "112221040", "story_v_out_112221.awb")

						arg_160_1:RecordAudio("112221040", var_163_9)
						arg_160_1:RecordAudio("112221040", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_112221", "112221040", "story_v_out_112221.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_112221", "112221040", "story_v_out_112221.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_10 and arg_160_1.time_ < var_163_2 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play112221041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 112221041
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play112221042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1081ui_story = arg_164_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_167_0 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 then
				arg_164_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 0) / var_167_0)
				arg_164_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1081ui_story"].transform.position).z)
				arg_164_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1081ui_story"].transform.localEulerAngles = arg_164_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 then
				arg_164_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1081ui_story"].transform.position).z)
				arg_164_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1081ui_story"].transform.localEulerAngles = arg_164_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_167_1 = 0
			local var_167_2 = 1.375

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(112221041).content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 57 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 57)

				if (57 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 57)) > 0 and var_167_2 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_6 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_6 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_6

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_6 and arg_164_1.time_ < var_167_1 + var_167_6 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play112221042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 112221042
		arg_168_1.duration_ = 5.33

		local var_168_0 = {
			ja = 4.833,
			ko = 5.266,
			zh = 5.333,
			en = 4.766
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play112221043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.4

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_1 = arg_168_1:GetWordFromCfg(112221042)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 16 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 16)

				if (16 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 16)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221042", "story_v_out_112221.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_112221", "112221042", "story_v_out_112221.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_112221", "112221042", "story_v_out_112221.awb")

						arg_168_1:RecordAudio("112221042", var_171_6)
						arg_168_1:RecordAudio("112221042", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_112221", "112221042", "story_v_out_112221.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_112221", "112221042", "story_v_out_112221.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play112221043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 112221043
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play112221044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1039ui_story = arg_172_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_175_0 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 then
				arg_172_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_172_1.time_ - 0) / var_175_0)
				arg_172_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1039ui_story"].transform.position).z)
				arg_172_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1039ui_story"].transform.localEulerAngles = arg_172_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 then
				arg_172_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_172_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1039ui_story"].transform.position).z)
				arg_172_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1039ui_story"].transform.localEulerAngles = arg_172_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_175_1 = 0
			local var_175_2 = 0.475

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(112221043).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 19 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 19)

				if (19 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 19)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
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

		arg_172_1:InitPlayNodeList()
	end,
	Play112221044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 112221044
		arg_176_1.duration_ = 6.17

		local var_176_0 = {
			ja = 6.166,
			ko = 4.7,
			zh = 4.666,
			en = 5.566
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play112221045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1039ui_story"]) and arg_176_1.var_.characterEffect1039ui_story == nil then
				arg_176_1.var_.characterEffect1039ui_story = arg_176_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1039ui_story"]) then
				if arg_176_1.var_.characterEffect1039ui_story and not isNil(arg_176_1.actors_["1039ui_story"]) then
					arg_176_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1039ui_story"]) and arg_176_1.var_.characterEffect1039ui_story then
				arg_176_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_179_2 = 0
			local var_179_3 = 0.575

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(112221044)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 23 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 23)

				if (23 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 23)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221044", "story_v_out_112221.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221044", "story_v_out_112221.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_out_112221", "112221044", "story_v_out_112221.awb")

						arg_176_1:RecordAudio("112221044", var_179_9)
						arg_176_1:RecordAudio("112221044", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_112221", "112221044", "story_v_out_112221.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_112221", "112221044", "story_v_out_112221.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play112221045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 112221045
		arg_180_1.duration_ = 10.37

		local var_180_0 = {
			ja = 7.966,
			ko = 7,
			zh = 6.4,
			en = 10.366
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play112221046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_183_0 = 0
			local var_183_1 = 0.65

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_2 = arg_180_1:GetWordFromCfg(112221045)
				local var_183_3 = arg_180_1:FormatText(var_183_2.content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 26 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_3) / 26)

				if (26 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_3) / 26)) > 0 and var_183_1 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221045", "story_v_out_112221.awb") ~= 0 then
					local var_183_6 = manager.audio:GetVoiceLength("story_v_out_112221", "112221045", "story_v_out_112221.awb") / 1000

					if var_183_6 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_0
					end

					if var_183_2.prefab_name ~= "" and arg_180_1.actors_[var_183_2.prefab_name] ~= nil then
						local var_183_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_2.prefab_name].transform, "story_v_out_112221", "112221045", "story_v_out_112221.awb")

						arg_180_1:RecordAudio("112221045", var_183_7)
						arg_180_1:RecordAudio("112221045", var_183_7)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_112221", "112221045", "story_v_out_112221.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_112221", "112221045", "story_v_out_112221.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_8 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_8 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_8

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_8 and arg_180_1.time_ < var_183_0 + var_183_8 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play112221046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 112221046
		arg_184_1.duration_ = 7.77

		local var_184_0 = {
			ja = 7.633,
			ko = 3.866,
			zh = 5.766,
			en = 7.766
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play112221047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_187_0 = 0
			local var_187_1 = 0.65

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_2 = arg_184_1:GetWordFromCfg(112221046)
				local var_187_3 = arg_184_1:FormatText(var_187_2.content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 26 <= 0 and var_187_1 or var_187_1 * (utf8.len(var_187_3) / 26)

				if (26 <= 0 and var_187_1 or var_187_1 * (utf8.len(var_187_3) / 26)) > 0 and var_187_1 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221046", "story_v_out_112221.awb") ~= 0 then
					local var_187_6 = manager.audio:GetVoiceLength("story_v_out_112221", "112221046", "story_v_out_112221.awb") / 1000

					if var_187_6 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_0
					end

					if var_187_2.prefab_name ~= "" and arg_184_1.actors_[var_187_2.prefab_name] ~= nil then
						local var_187_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_2.prefab_name].transform, "story_v_out_112221", "112221046", "story_v_out_112221.awb")

						arg_184_1:RecordAudio("112221046", var_187_7)
						arg_184_1:RecordAudio("112221046", var_187_7)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_112221", "112221046", "story_v_out_112221.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_112221", "112221046", "story_v_out_112221.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_8 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_8 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_8

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_8 and arg_184_1.time_ < var_187_0 + var_187_8 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play112221047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 112221047
		arg_188_1.duration_ = 8.63

		local var_188_0 = {
			ja = 7.566,
			ko = 7.833,
			zh = 5.3,
			en = 8.633
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play112221048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action446")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_191_0 = 0
			local var_191_1 = 0.675

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_2 = arg_188_1:GetWordFromCfg(112221047)
				local var_191_3 = arg_188_1:FormatText(var_191_2.content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 27 <= 0 and var_191_1 or var_191_1 * (utf8.len(var_191_3) / 27)

				if (27 <= 0 and var_191_1 or var_191_1 * (utf8.len(var_191_3) / 27)) > 0 and var_191_1 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221047", "story_v_out_112221.awb") ~= 0 then
					local var_191_6 = manager.audio:GetVoiceLength("story_v_out_112221", "112221047", "story_v_out_112221.awb") / 1000

					if var_191_6 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_0
					end

					if var_191_2.prefab_name ~= "" and arg_188_1.actors_[var_191_2.prefab_name] ~= nil then
						local var_191_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_2.prefab_name].transform, "story_v_out_112221", "112221047", "story_v_out_112221.awb")

						arg_188_1:RecordAudio("112221047", var_191_7)
						arg_188_1:RecordAudio("112221047", var_191_7)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_112221", "112221047", "story_v_out_112221.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_112221", "112221047", "story_v_out_112221.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_8 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_8 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_8

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_8 and arg_188_1.time_ < var_191_0 + var_191_8 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play112221048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 112221048
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play112221049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1039ui_story"]) and arg_192_1.var_.characterEffect1039ui_story == nil then
				arg_192_1.var_.characterEffect1039ui_story = arg_192_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1039ui_story"]) then
				if arg_192_1.var_.characterEffect1039ui_story and not isNil(arg_192_1.actors_["1039ui_story"]) then
					arg_192_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_0)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1039ui_story"]) and arg_192_1.var_.characterEffect1039ui_story then
				arg_192_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_195_1 = 0
			local var_195_2 = 0.3

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(112221048).content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 12 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 12)

				if (12 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 12)) > 0 and var_195_2 < var_195_5 then
					arg_192_1.talkMaxDuration = var_195_5

					if var_195_5 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + var_195_1
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_6 = math.max(var_195_2, arg_192_1.talkMaxDuration)

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_6 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_1) / var_195_6

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_1 + var_195_6 and arg_192_1.time_ < var_195_1 + var_195_6 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play112221049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 112221049
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play112221050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1039ui_story = arg_196_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_199_0 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 then
				arg_196_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_196_1.time_ - 0) / var_199_0)
				arg_196_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1039ui_story"].transform.position).z)
				arg_196_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1039ui_story"].transform.localEulerAngles = arg_196_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 then
				arg_196_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_196_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1039ui_story"].transform.position).z)
				arg_196_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1039ui_story"].transform.localEulerAngles = arg_196_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_199_1 = 0
			local var_199_2 = 1.25

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(112221049).content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 50 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_3) / 50)

				if (50 <= 0 and var_199_2 or var_199_2 * (utf8.len(var_199_3) / 50)) > 0 and var_199_2 < var_199_5 then
					arg_196_1.talkMaxDuration = var_199_5

					if var_199_5 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + var_199_1
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_6 = math.max(var_199_2, arg_196_1.talkMaxDuration)

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_6 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_1) / var_199_6

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_1 + var_199_6 and arg_196_1.time_ < var_199_1 + var_199_6 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
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

		arg_196_1:InitPlayNodeList()
	end,
	Play112221050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 112221050
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play112221051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.275

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(112221050).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 11 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 11)

				if (11 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 11)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play112221051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 112221051
		arg_204_1.duration_ = 12.17

		local var_204_0 = {
			ja = 8.533,
			ko = 4.166,
			zh = 12.166,
			en = 4.366
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play112221052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1027ui_story = arg_204_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_207_0 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 then
				arg_204_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_204_1.time_ - 0) / var_207_0)
				arg_204_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1027ui_story"].transform.position).z)
				arg_204_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1027ui_story"].transform.localEulerAngles = arg_204_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 then
				arg_204_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_204_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1027ui_story"].transform.position).z)
				arg_204_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1027ui_story"].transform.localEulerAngles = arg_204_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_207_1 = arg_204_1.actors_["1027ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect1027ui_story == nil then
				arg_204_1.var_.characterEffect1027ui_story = var_207_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_2 and not isNil(var_207_1) then
				if arg_204_1.var_.characterEffect1027ui_story and not isNil(var_207_1) then
					arg_204_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_2 and arg_204_1.time_ < 0 + var_207_2 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect1027ui_story then
				arg_204_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_1")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_207_4 = 0
			local var_207_5 = 0.325

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_6 = arg_204_1:GetWordFromCfg(112221051)
				local var_207_7 = arg_204_1:FormatText(var_207_6.content)

				arg_204_1.text_.text = var_207_7

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 11 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 11)

				if (11 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 11)) > 0 and var_207_5 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_7
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221051", "story_v_out_112221.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_112221", "112221051", "story_v_out_112221.awb") / 1000

					if var_207_10 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_4
					end

					if var_207_6.prefab_name ~= "" and arg_204_1.actors_[var_207_6.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_6.prefab_name].transform, "story_v_out_112221", "112221051", "story_v_out_112221.awb")

						arg_204_1:RecordAudio("112221051", var_207_11)
						arg_204_1:RecordAudio("112221051", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_112221", "112221051", "story_v_out_112221.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_112221", "112221051", "story_v_out_112221.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_12 and arg_204_1.time_ < var_207_4 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play112221052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 112221052
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play112221053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1027ui_story"]) and arg_208_1.var_.characterEffect1027ui_story == nil then
				arg_208_1.var_.characterEffect1027ui_story = arg_208_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1027ui_story"]) then
				if arg_208_1.var_.characterEffect1027ui_story and not isNil(arg_208_1.actors_["1027ui_story"]) then
					arg_208_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1027ui_story"]) and arg_208_1.var_.characterEffect1027ui_story then
				arg_208_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_211_1 = 0
			local var_211_2 = 0.9

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(112221052).content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 36 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 36)

				if (36 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 36)) > 0 and var_211_2 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_6 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_6 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_6

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_6 and arg_208_1.time_ < var_211_1 + var_211_6 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play112221053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 112221053
		arg_212_1.duration_ = 6.33

		local var_212_0 = {
			ja = 4.3,
			ko = 3.633,
			zh = 4.666,
			en = 6.333
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play112221054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1027ui_story = arg_212_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1027ui_story"].transform.position).z)
				arg_212_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1027ui_story"].transform.localEulerAngles = arg_212_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1027ui_story"].transform.position).z)
				arg_212_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1027ui_story"].transform.localEulerAngles = arg_212_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_215_1 = arg_212_1.actors_["1148ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1148ui_story = var_215_1.localPosition
			end

			local var_215_2 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_2 then
				var_215_1.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_212_1.time_ - 0) / var_215_2)
				var_215_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_1.position).x, (manager.ui.mainCamera.transform.position - var_215_1.position).y, (manager.ui.mainCamera.transform.position - var_215_1.position).z)
				var_215_1.localEulerAngles.z = 0
				var_215_1.localEulerAngles.x = 0
				var_215_1.localEulerAngles = var_215_1.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_2 and arg_212_1.time_ < 0 + var_215_2 + arg_215_0 then
				var_215_1.localPosition = Vector3.New(0, -0.8, -6.2)
				var_215_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_1.position).x, (manager.ui.mainCamera.transform.position - var_215_1.position).y, (manager.ui.mainCamera.transform.position - var_215_1.position).z)
				var_215_1.localEulerAngles.z = 0
				var_215_1.localEulerAngles.x = 0
				var_215_1.localEulerAngles = var_215_1.localEulerAngles
			end

			local var_215_3 = arg_212_1.actors_["1148ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_3) and arg_212_1.var_.characterEffect1148ui_story == nil then
				arg_212_1.var_.characterEffect1148ui_story = var_215_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_4 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 and not isNil(var_215_3) then
				if arg_212_1.var_.characterEffect1148ui_story and not isNil(var_215_3) then
					arg_212_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 and not isNil(var_215_3) and arg_212_1.var_.characterEffect1148ui_story then
				arg_212_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_215_6 = 0
			local var_215_7 = 0.5

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_8 = arg_212_1:GetWordFromCfg(112221053)
				local var_215_9 = arg_212_1:FormatText(var_215_8.content)

				arg_212_1.text_.text = var_215_9

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 20 <= 0 and var_215_7 or var_215_7 * (utf8.len(var_215_9) / 20)

				if (20 <= 0 and var_215_7 or var_215_7 * (utf8.len(var_215_9) / 20)) > 0 and var_215_7 < var_215_11 then
					arg_212_1.talkMaxDuration = var_215_11

					if var_215_11 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_9
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221053", "story_v_out_112221.awb") ~= 0 then
					local var_215_12 = manager.audio:GetVoiceLength("story_v_out_112221", "112221053", "story_v_out_112221.awb") / 1000

					if var_215_12 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_12 + var_215_6
					end

					if var_215_8.prefab_name ~= "" and arg_212_1.actors_[var_215_8.prefab_name] ~= nil then
						local var_215_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_8.prefab_name].transform, "story_v_out_112221", "112221053", "story_v_out_112221.awb")

						arg_212_1:RecordAudio("112221053", var_215_13)
						arg_212_1:RecordAudio("112221053", var_215_13)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_112221", "112221053", "story_v_out_112221.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_112221", "112221053", "story_v_out_112221.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_14 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_14 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_14

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_14 and arg_212_1.time_ < var_215_6 + var_215_14 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play112221054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 112221054
		arg_216_1.duration_ = 13.87

		local var_216_0 = {
			ja = 13.866,
			ko = 7.466,
			zh = 9.133,
			en = 10.333
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play112221055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1148ui_story = arg_216_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1148ui_story"].transform.position).z)
				arg_216_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1148ui_story"].transform.localEulerAngles = arg_216_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				arg_216_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1148ui_story"].transform.position).z)
				arg_216_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1148ui_story"].transform.localEulerAngles = arg_216_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_219_1 = arg_216_1.actors_["1148ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1148ui_story == nil then
				arg_216_1.var_.characterEffect1148ui_story = var_219_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_2 and not isNil(var_219_1) then
				if arg_216_1.var_.characterEffect1148ui_story and not isNil(var_219_1) then
					arg_216_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_2)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_2 and arg_216_1.time_ < 0 + var_219_2 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1148ui_story then
				arg_216_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_219_3 = arg_216_1.actors_["1039ui_story"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1039ui_story = var_219_3.localPosition
			end

			local var_219_4 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				var_219_3.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_216_1.time_ - 0) / var_219_4)
				var_219_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_3.position).x, (manager.ui.mainCamera.transform.position - var_219_3.position).y, (manager.ui.mainCamera.transform.position - var_219_3.position).z)
				var_219_3.localEulerAngles.z = 0
				var_219_3.localEulerAngles.x = 0
				var_219_3.localEulerAngles = var_219_3.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 then
				var_219_3.localPosition = Vector3.New(0.7, -1.01, -5.9)
				var_219_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_3.position).x, (manager.ui.mainCamera.transform.position - var_219_3.position).y, (manager.ui.mainCamera.transform.position - var_219_3.position).z)
				var_219_3.localEulerAngles.z = 0
				var_219_3.localEulerAngles.x = 0
				var_219_3.localEulerAngles = var_219_3.localEulerAngles
			end

			local var_219_5 = arg_216_1.actors_["1039ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_5) and arg_216_1.var_.characterEffect1039ui_story == nil then
				arg_216_1.var_.characterEffect1039ui_story = var_219_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_6 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_6 and not isNil(var_219_5) then
				if arg_216_1.var_.characterEffect1039ui_story and not isNil(var_219_5) then
					arg_216_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_6 and arg_216_1.time_ < 0 + var_219_6 + arg_219_0 and not isNil(var_219_5) and arg_216_1.var_.characterEffect1039ui_story then
				arg_216_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_219_8 = 0
			local var_219_9 = 0.95

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_10 = arg_216_1:GetWordFromCfg(112221054)
				local var_219_11 = arg_216_1:FormatText(var_219_10.content)

				arg_216_1.text_.text = var_219_11

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_13 = 38 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 38)

				if (38 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 38)) > 0 and var_219_9 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_8
					end
				end

				arg_216_1.text_.text = var_219_11
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221054", "story_v_out_112221.awb") ~= 0 then
					local var_219_14 = manager.audio:GetVoiceLength("story_v_out_112221", "112221054", "story_v_out_112221.awb") / 1000

					if var_219_14 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_8
					end

					if var_219_10.prefab_name ~= "" and arg_216_1.actors_[var_219_10.prefab_name] ~= nil then
						local var_219_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_10.prefab_name].transform, "story_v_out_112221", "112221054", "story_v_out_112221.awb")

						arg_216_1:RecordAudio("112221054", var_219_15)
						arg_216_1:RecordAudio("112221054", var_219_15)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_112221", "112221054", "story_v_out_112221.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_112221", "112221054", "story_v_out_112221.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_9, arg_216_1.talkMaxDuration)

			if var_219_8 <= arg_216_1.time_ and arg_216_1.time_ < var_219_8 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_8) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_8 + var_219_16 and arg_216_1.time_ < var_219_8 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_216_1:InitPlayNodeList()
	end,
	Play112221055 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 112221055
		arg_220_1.duration_ = 4.93

		local var_220_0 = {
			ja = 4.433,
			ko = 4.933,
			zh = 3.666,
			en = 4.6
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play112221056(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1148ui_story"]) and arg_220_1.var_.characterEffect1148ui_story == nil then
				arg_220_1.var_.characterEffect1148ui_story = arg_220_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1148ui_story"]) then
				if arg_220_1.var_.characterEffect1148ui_story and not isNil(arg_220_1.actors_["1148ui_story"]) then
					arg_220_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1148ui_story"]) and arg_220_1.var_.characterEffect1148ui_story then
				arg_220_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_223_2 = arg_220_1.actors_["1039ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.characterEffect1039ui_story == nil then
				arg_220_1.var_.characterEffect1039ui_story = var_223_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_3 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 and not isNil(var_223_2) then
				if arg_220_1.var_.characterEffect1039ui_story and not isNil(var_223_2) then
					arg_220_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_3)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 and not isNil(var_223_2) and arg_220_1.var_.characterEffect1039ui_story then
				arg_220_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_223_4 = 0
			local var_223_5 = 0.475

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(112221055)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 19 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 19)

				if (19 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 19)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221055", "story_v_out_112221.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_out_112221", "112221055", "story_v_out_112221.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_out_112221", "112221055", "story_v_out_112221.awb")

						arg_220_1:RecordAudio("112221055", var_223_11)
						arg_220_1:RecordAudio("112221055", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_112221", "112221055", "story_v_out_112221.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_112221", "112221055", "story_v_out_112221.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play112221056 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 112221056
		arg_224_1.duration_ = 9.83

		local var_224_0 = {
			ja = 8.1,
			ko = 9.833,
			zh = 8.233,
			en = 8.766
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play112221057(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1039ui_story = arg_224_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_227_0 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 then
				arg_224_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_224_1.time_ - 0) / var_227_0)
				arg_224_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1039ui_story"].transform.position).z)
				arg_224_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1039ui_story"].transform.localEulerAngles = arg_224_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 then
				arg_224_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_224_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1039ui_story"].transform.position).z)
				arg_224_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1039ui_story"].transform.localEulerAngles = arg_224_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_227_1 = arg_224_1.actors_["1084ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1084ui_story = var_227_1.localPosition
			end

			local var_227_2 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_2 then
				var_227_1.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_224_1.time_ - 0) / var_227_2)
				var_227_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_1.position).x, (manager.ui.mainCamera.transform.position - var_227_1.position).y, (manager.ui.mainCamera.transform.position - var_227_1.position).z)
				var_227_1.localEulerAngles.z = 0
				var_227_1.localEulerAngles.x = 0
				var_227_1.localEulerAngles = var_227_1.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_2 and arg_224_1.time_ < 0 + var_227_2 + arg_227_0 then
				var_227_1.localPosition = Vector3.New(0.7, -0.97, -6)
				var_227_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_1.position).x, (manager.ui.mainCamera.transform.position - var_227_1.position).y, (manager.ui.mainCamera.transform.position - var_227_1.position).z)
				var_227_1.localEulerAngles.z = 0
				var_227_1.localEulerAngles.x = 0
				var_227_1.localEulerAngles = var_227_1.localEulerAngles
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_227_3 = arg_224_1.actors_["1148ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_3) and arg_224_1.var_.characterEffect1148ui_story == nil then
				arg_224_1.var_.characterEffect1148ui_story = var_227_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_4 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 and not isNil(var_227_3) then
				if arg_224_1.var_.characterEffect1148ui_story and not isNil(var_227_3) then
					arg_224_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_4)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 and not isNil(var_227_3) and arg_224_1.var_.characterEffect1148ui_story then
				arg_224_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_227_5 = arg_224_1.actors_["1084ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.characterEffect1084ui_story == nil then
				arg_224_1.var_.characterEffect1084ui_story = var_227_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_6 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_6 and not isNil(var_227_5) then
				if arg_224_1.var_.characterEffect1084ui_story and not isNil(var_227_5) then
					arg_224_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_6 and arg_224_1.time_ < 0 + var_227_6 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.characterEffect1084ui_story then
				arg_224_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_227_8 = 0
			local var_227_9 = 0.975

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_10 = arg_224_1:GetWordFromCfg(112221056)
				local var_227_11 = arg_224_1:FormatText(var_227_10.content)

				arg_224_1.text_.text = var_227_11

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_13 = 39 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 39)

				if (39 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 39)) > 0 and var_227_9 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_8
					end
				end

				arg_224_1.text_.text = var_227_11
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221056", "story_v_out_112221.awb") ~= 0 then
					local var_227_14 = manager.audio:GetVoiceLength("story_v_out_112221", "112221056", "story_v_out_112221.awb") / 1000

					if var_227_14 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_14 + var_227_8
					end

					if var_227_10.prefab_name ~= "" and arg_224_1.actors_[var_227_10.prefab_name] ~= nil then
						local var_227_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_10.prefab_name].transform, "story_v_out_112221", "112221056", "story_v_out_112221.awb")

						arg_224_1:RecordAudio("112221056", var_227_15)
						arg_224_1:RecordAudio("112221056", var_227_15)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_112221", "112221056", "story_v_out_112221.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_112221", "112221056", "story_v_out_112221.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_16 = math.max(var_227_9, arg_224_1.talkMaxDuration)

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_16 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_8) / var_227_16

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_8 + var_227_16 and arg_224_1.time_ < var_227_8 + var_227_16 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play112221057 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 112221057
		arg_228_1.duration_ = 3.4

		local var_228_0 = {
			ja = 2.866,
			ko = 2.6,
			zh = 3.4,
			en = 3.366
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play112221058(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1084ui_story"]) and arg_228_1.var_.characterEffect1084ui_story == nil then
				arg_228_1.var_.characterEffect1084ui_story = arg_228_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1084ui_story"]) then
				if arg_228_1.var_.characterEffect1084ui_story and not isNil(arg_228_1.actors_["1084ui_story"]) then
					arg_228_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_0)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1084ui_story"]) and arg_228_1.var_.characterEffect1084ui_story then
				arg_228_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_231_1 = arg_228_1.actors_["1148ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1148ui_story == nil then
				arg_228_1.var_.characterEffect1148ui_story = var_231_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 and not isNil(var_231_1) then
				if arg_228_1.var_.characterEffect1148ui_story and not isNil(var_231_1) then
					arg_228_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1148ui_story then
				arg_228_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_231_4 = 0
			local var_231_5 = 0.225

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(112221057)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 9 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 9)

				if (9 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 9)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221057", "story_v_out_112221.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_112221", "112221057", "story_v_out_112221.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_112221", "112221057", "story_v_out_112221.awb")

						arg_228_1:RecordAudio("112221057", var_231_11)
						arg_228_1:RecordAudio("112221057", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_112221", "112221057", "story_v_out_112221.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_112221", "112221057", "story_v_out_112221.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play112221058 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 112221058
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play112221059(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1148ui_story = arg_232_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).z)
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles = arg_232_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1148ui_story"].transform.position).z)
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1148ui_story"].transform.localEulerAngles = arg_232_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["1084ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1084ui_story = var_235_1.localPosition
			end

			local var_235_2 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 then
				var_235_1.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_2)
				var_235_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_1.position).x, (manager.ui.mainCamera.transform.position - var_235_1.position).y, (manager.ui.mainCamera.transform.position - var_235_1.position).z)
				var_235_1.localEulerAngles.z = 0
				var_235_1.localEulerAngles.x = 0
				var_235_1.localEulerAngles = var_235_1.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 then
				var_235_1.localPosition = Vector3.New(0, 100, 0)
				var_235_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_1.position).x, (manager.ui.mainCamera.transform.position - var_235_1.position).y, (manager.ui.mainCamera.transform.position - var_235_1.position).z)
				var_235_1.localEulerAngles.z = 0
				var_235_1.localEulerAngles.x = 0
				var_235_1.localEulerAngles = var_235_1.localEulerAngles
			end

			local var_235_3 = 0
			local var_235_4 = 0.7

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_3 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_5 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(112221058).content)

				arg_232_1.text_.text = var_235_5

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_7 = 28 <= 0 and var_235_4 or var_235_4 * (utf8.len(var_235_5) / 28)

				if (28 <= 0 and var_235_4 or var_235_4 * (utf8.len(var_235_5) / 28)) > 0 and var_235_4 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_3 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_3
					end
				end

				arg_232_1.text_.text = var_235_5
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_8 = math.max(var_235_4, arg_232_1.talkMaxDuration)

			if var_235_3 <= arg_232_1.time_ and arg_232_1.time_ < var_235_3 + var_235_8 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_3) / var_235_8

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_3 + var_235_8 and arg_232_1.time_ < var_235_3 + var_235_8 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play112221059 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 112221059
		arg_236_1.duration_ = 11.07

		local var_236_0 = {
			ja = 11.066,
			ko = 5.866,
			zh = 7.333,
			en = 8.733
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play112221060(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1081ui_story = arg_236_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1081ui_story"].transform.position).z)
				arg_236_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1081ui_story"].transform.localEulerAngles = arg_236_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_236_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1081ui_story"].transform.position).z)
				arg_236_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1081ui_story"].transform.localEulerAngles = arg_236_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["1081ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1081ui_story == nil then
				arg_236_1.var_.characterEffect1081ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect1081ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1081ui_story then
				arg_236_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_239_4 = 0
			local var_239_5 = 0.7

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(112221059)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_9 = 28 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 28)

				if (28 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 28)) > 0 and var_239_5 < var_239_9 then
					arg_236_1.talkMaxDuration = var_239_9

					if var_239_9 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_9 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221059", "story_v_out_112221.awb") ~= 0 then
					local var_239_10 = manager.audio:GetVoiceLength("story_v_out_112221", "112221059", "story_v_out_112221.awb") / 1000

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end

					if var_239_6.prefab_name ~= "" and arg_236_1.actors_[var_239_6.prefab_name] ~= nil then
						local var_239_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_6.prefab_name].transform, "story_v_out_112221", "112221059", "story_v_out_112221.awb")

						arg_236_1:RecordAudio("112221059", var_239_11)
						arg_236_1:RecordAudio("112221059", var_239_11)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_112221", "112221059", "story_v_out_112221.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_112221", "112221059", "story_v_out_112221.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_12 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_12 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_12

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_12 and arg_236_1.time_ < var_239_4 + var_239_12 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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

		arg_236_1:InitPlayNodeList()
	end,
	Play112221060 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 112221060
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play112221061(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1081ui_story = arg_240_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1081ui_story"].transform.position).z)
				arg_240_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1081ui_story"].transform.localEulerAngles = arg_240_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_240_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1081ui_story"].transform.position).z)
				arg_240_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1081ui_story"].transform.localEulerAngles = arg_240_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.actors_["1027ui_story"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1027ui_story = var_243_1.localPosition
			end

			local var_243_2 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_2 then
				var_243_1.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_240_1.time_ - 0) / var_243_2)
				var_243_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_1.position).x, (manager.ui.mainCamera.transform.position - var_243_1.position).y, (manager.ui.mainCamera.transform.position - var_243_1.position).z)
				var_243_1.localEulerAngles.z = 0
				var_243_1.localEulerAngles.x = 0
				var_243_1.localEulerAngles = var_243_1.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_2 and arg_240_1.time_ < 0 + var_243_2 + arg_243_0 then
				var_243_1.localPosition = Vector3.New(0, -0.81, -5.8)
				var_243_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_1.position).x, (manager.ui.mainCamera.transform.position - var_243_1.position).y, (manager.ui.mainCamera.transform.position - var_243_1.position).z)
				var_243_1.localEulerAngles.z = 0
				var_243_1.localEulerAngles.x = 0
				var_243_1.localEulerAngles = var_243_1.localEulerAngles
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_243_3 = 0
			local var_243_4 = 0.825

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_3 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_5 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(112221060).content)

				arg_240_1.text_.text = var_243_5

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_7 = 33 <= 0 and var_243_4 or var_243_4 * (utf8.len(var_243_5) / 33)

				if (33 <= 0 and var_243_4 or var_243_4 * (utf8.len(var_243_5) / 33)) > 0 and var_243_4 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_3 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_3
					end
				end

				arg_240_1.text_.text = var_243_5
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_8 = math.max(var_243_4, arg_240_1.talkMaxDuration)

			if var_243_3 <= arg_240_1.time_ and arg_240_1.time_ < var_243_3 + var_243_8 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_3) / var_243_8

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_3 + var_243_8 and arg_240_1.time_ < var_243_3 + var_243_8 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play112221061 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 112221061
		arg_244_1.duration_ = 8.33

		local var_244_0 = {
			ja = 5,
			ko = 3.3,
			zh = 5.233,
			en = 8.333
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play112221062(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1027ui_story"]) and arg_244_1.var_.characterEffect1027ui_story == nil then
				arg_244_1.var_.characterEffect1027ui_story = arg_244_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1027ui_story"]) then
				if arg_244_1.var_.characterEffect1027ui_story and not isNil(arg_244_1.actors_["1027ui_story"]) then
					arg_244_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1027ui_story"]) and arg_244_1.var_.characterEffect1027ui_story then
				arg_244_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_247_2 = 0
			local var_247_3 = 0.35

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_2 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_4 = arg_244_1:GetWordFromCfg(112221061)
				local var_247_5 = arg_244_1:FormatText(var_247_4.content)

				arg_244_1.text_.text = var_247_5

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_7 = 14 <= 0 and var_247_3 or var_247_3 * (utf8.len(var_247_5) / 14)

				if (14 <= 0 and var_247_3 or var_247_3 * (utf8.len(var_247_5) / 14)) > 0 and var_247_3 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_2
					end
				end

				arg_244_1.text_.text = var_247_5
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221061", "story_v_out_112221.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_112221", "112221061", "story_v_out_112221.awb") / 1000

					if var_247_8 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_2
					end

					if var_247_4.prefab_name ~= "" and arg_244_1.actors_[var_247_4.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_4.prefab_name].transform, "story_v_out_112221", "112221061", "story_v_out_112221.awb")

						arg_244_1:RecordAudio("112221061", var_247_9)
						arg_244_1:RecordAudio("112221061", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_112221", "112221061", "story_v_out_112221.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_112221", "112221061", "story_v_out_112221.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_3, arg_244_1.talkMaxDuration)

			if var_247_2 <= arg_244_1.time_ and arg_244_1.time_ < var_247_2 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_2) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_2 + var_247_10 and arg_244_1.time_ < var_247_2 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play112221062 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 112221062
		arg_248_1.duration_ = 16.5

		local var_248_0 = {
			ja = 9.166,
			ko = 5.133,
			zh = 9.033,
			en = 16.5
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play112221063(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_251_0 = 0
			local var_251_1 = 0.475

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_2 = arg_248_1:GetWordFromCfg(112221062)
				local var_251_3 = arg_248_1:FormatText(var_251_2.content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 19 <= 0 and var_251_1 or var_251_1 * (utf8.len(var_251_3) / 19)

				if (19 <= 0 and var_251_1 or var_251_1 * (utf8.len(var_251_3) / 19)) > 0 and var_251_1 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221062", "story_v_out_112221.awb") ~= 0 then
					local var_251_6 = manager.audio:GetVoiceLength("story_v_out_112221", "112221062", "story_v_out_112221.awb") / 1000

					if var_251_6 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_0
					end

					if var_251_2.prefab_name ~= "" and arg_248_1.actors_[var_251_2.prefab_name] ~= nil then
						local var_251_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_2.prefab_name].transform, "story_v_out_112221", "112221062", "story_v_out_112221.awb")

						arg_248_1:RecordAudio("112221062", var_251_7)
						arg_248_1:RecordAudio("112221062", var_251_7)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_112221", "112221062", "story_v_out_112221.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_112221", "112221062", "story_v_out_112221.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_8 and arg_248_1.time_ < var_251_0 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play112221063 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 112221063
		arg_252_1.duration_ = 5.13

		local var_252_0 = {
			ja = 4.433,
			ko = 4.433,
			zh = 5.133,
			en = 4.633
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play112221064(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1027ui_story"]) and arg_252_1.var_.characterEffect1027ui_story == nil then
				arg_252_1.var_.characterEffect1027ui_story = arg_252_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1027ui_story"]) then
				if arg_252_1.var_.characterEffect1027ui_story and not isNil(arg_252_1.actors_["1027ui_story"]) then
					arg_252_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1027ui_story"]) and arg_252_1.var_.characterEffect1027ui_story then
				arg_252_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_255_1 = 0
			local var_255_2 = 0.45

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(112221063)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_6 = 18 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 18)

				if (18 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_4) / 18)) > 0 and var_255_2 < var_255_6 then
					arg_252_1.talkMaxDuration = var_255_6

					if var_255_6 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_6 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112221", "112221063", "story_v_out_112221.awb") ~= 0 then
					local var_255_7 = manager.audio:GetVoiceLength("story_v_out_112221", "112221063", "story_v_out_112221.awb") / 1000

					if var_255_7 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_1
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_112221", "112221063", "story_v_out_112221.awb")

						arg_252_1:RecordAudio("112221063", var_255_8)
						arg_252_1:RecordAudio("112221063", var_255_8)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_112221", "112221063", "story_v_out_112221.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_112221", "112221063", "story_v_out_112221.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_9 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_9 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_9

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_9 and arg_252_1.time_ < var_255_1 + var_255_9 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play112221064 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 112221064
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
			arg_256_1.auto_ = false
		end

		function arg_256_1.playNext_(arg_258_0)
			arg_256_1.onStoryFinished_()
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1027ui_story = arg_256_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_259_0 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				arg_256_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_256_1.time_ - 0) / var_259_0)
				arg_256_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1027ui_story"].transform.position).z)
				arg_256_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1027ui_story"].transform.localEulerAngles = arg_256_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				arg_256_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1027ui_story"].transform.position).z)
				arg_256_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1027ui_story"].transform.localEulerAngles = arg_256_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_259_1 = 0
			local var_259_2 = 1.2

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(112221064).content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 48 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 48)

				if (48 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 48)) > 0 and var_259_2 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_6 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_6 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_6

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_6 and arg_256_1.time_ < var_259_1 + var_259_6 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02"
	},
	voices = {
		"story_v_out_112221.awb"
	}
}
