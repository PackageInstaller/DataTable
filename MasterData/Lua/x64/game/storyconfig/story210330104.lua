return {
	Play103304001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103304001
		arg_1_1.duration_ = 5.43

		local var_1_0 = {
			ja = 5.433,
			ko = 4.3,
			zh = 4.133,
			en = 4.366
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play103304002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST18 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST18")
				var_4_0.name = "ST18"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST18 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST18

				arg_1_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST18" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 1

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

			local var_4_8 = "1033ui_story"

			if arg_1_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1033ui_story"].transform

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1.var_.moveOldPos1033ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_1_1.time_ - 1) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1 + var_4_13 and arg_1_1.time_ < 1 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.01, -6.13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1033ui_story"]

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1033ui_story == nil then
				arg_1_1.var_.characterEffect1033ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1033ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1 + var_4_15 and arg_1_1.time_ < 1 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1033ui_story then
				arg_1_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_1")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			local var_4_23 = 1
			local var_4_24 = 0.325

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(103304001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 13 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 13)

				if (13 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 13)) > 0 and var_4_24 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28

					if var_4_28 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304001", "story_v_side_old_103304.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304001", "story_v_side_old_103304.awb") / 1000

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_side_old_103304", "103304001", "story_v_side_old_103304.awb")

						arg_1_1:RecordAudio("103304001", var_4_30)
						arg_1_1:RecordAudio("103304001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304001", "story_v_side_old_103304.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304001", "story_v_side_old_103304.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_31 and arg_1_1.time_ < var_4_23 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play103304002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 103304002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play103304003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["1033ui_story"]) and arg_7_1.var_.characterEffect1033ui_story == nil then
				arg_7_1.var_.characterEffect1033ui_story = arg_7_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["1033ui_story"]) then
				if arg_7_1.var_.characterEffect1033ui_story and not isNil(arg_7_1.actors_["1033ui_story"]) then
					arg_7_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["1033ui_story"]) and arg_7_1.var_.characterEffect1033ui_story then
				arg_7_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_10_1 = 0
			local var_10_2 = 1.4

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_3 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(103304002).content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 56 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 56)

				if (56 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 56)) > 0 and var_10_2 < var_10_5 then
					arg_7_1.talkMaxDuration = var_10_5

					if var_10_5 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + var_10_1
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_6 = math.max(var_10_2, arg_7_1.talkMaxDuration)

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_6 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_1) / var_10_6

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_1 + var_10_6 and arg_7_1.time_ < var_10_1 + var_10_6 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play103304003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 103304003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play103304004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.6

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
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

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(103304003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 24 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 24)

				if (24 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 24)) > 0 and var_14_0 < var_14_3 then
					arg_11_1.talkMaxDuration = var_14_3

					if var_14_3 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_3 + 0
					end
				end

				arg_11_1.text_.text = var_14_1
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_4 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_4

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play103304004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 103304004
		arg_15_1.duration_ = 13.6

		local var_15_0 = {
			ja = 13.6,
			ko = 9.133,
			zh = 6,
			en = 5.333
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
				arg_15_0:Play103304005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["1033ui_story"]) and arg_15_1.var_.characterEffect1033ui_story == nil then
				arg_15_1.var_.characterEffect1033ui_story = arg_15_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["1033ui_story"]) then
				if arg_15_1.var_.characterEffect1033ui_story and not isNil(arg_15_1.actors_["1033ui_story"]) then
					arg_15_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["1033ui_story"]) and arg_15_1.var_.characterEffect1033ui_story then
				arg_15_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_18_2 = 0
			local var_18_3 = 0.9

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_2 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_4 = arg_15_1:GetWordFromCfg(103304004)
				local var_18_5 = arg_15_1:FormatText(var_18_4.content)

				arg_15_1.text_.text = var_18_5

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_7 = 36 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_5) / 36)

				if (36 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_5) / 36)) > 0 and var_18_3 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_2
					end
				end

				arg_15_1.text_.text = var_18_5
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304004", "story_v_side_old_103304.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304004", "story_v_side_old_103304.awb") / 1000

					if var_18_8 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_2
					end

					if var_18_4.prefab_name ~= "" and arg_15_1.actors_[var_18_4.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_4.prefab_name].transform, "story_v_side_old_103304", "103304004", "story_v_side_old_103304.awb")

						arg_15_1:RecordAudio("103304004", var_18_9)
						arg_15_1:RecordAudio("103304004", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304004", "story_v_side_old_103304.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304004", "story_v_side_old_103304.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_10 = math.max(var_18_3, arg_15_1.talkMaxDuration)

			if var_18_2 <= arg_15_1.time_ and arg_15_1.time_ < var_18_2 + var_18_10 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_2) / var_18_10

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_2 + var_18_10 and arg_15_1.time_ < var_18_2 + var_18_10 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play103304005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 103304005
		arg_19_1.duration_ = 17.27

		local var_19_0 = {
			ja = 17.266,
			ko = 12.933,
			zh = 9.4,
			en = 12.566
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
				arg_19_0:Play103304006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_22_0 = 0
			local var_22_1 = 1.25

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_2 = arg_19_1:GetWordFromCfg(103304005)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 50 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_3) / 50)

				if (50 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_3) / 50)) > 0 and var_22_1 < var_22_5 then
					arg_19_1.talkMaxDuration = var_22_5

					if var_22_5 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304005", "story_v_side_old_103304.awb") ~= 0 then
					local var_22_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304005", "story_v_side_old_103304.awb") / 1000

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end

					if var_22_2.prefab_name ~= "" and arg_19_1.actors_[var_22_2.prefab_name] ~= nil then
						local var_22_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_2.prefab_name].transform, "story_v_side_old_103304", "103304005", "story_v_side_old_103304.awb")

						arg_19_1:RecordAudio("103304005", var_22_7)
						arg_19_1:RecordAudio("103304005", var_22_7)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304005", "story_v_side_old_103304.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304005", "story_v_side_old_103304.awb")
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
	Play103304006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 103304006
		arg_23_1.duration_ = 14.4

		local var_23_0 = {
			ja = 14.133,
			ko = 14.4,
			zh = 9.6,
			en = 11.133
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play103304007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action482")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_26_0 = 0
			local var_26_1 = 1.175

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_2 = arg_23_1:GetWordFromCfg(103304006)
				local var_26_3 = arg_23_1:FormatText(var_26_2.content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 47 <= 0 and var_26_1 or var_26_1 * (utf8.len(var_26_3) / 47)

				if (47 <= 0 and var_26_1 or var_26_1 * (utf8.len(var_26_3) / 47)) > 0 and var_26_1 < var_26_5 then
					arg_23_1.talkMaxDuration = var_26_5

					if var_26_5 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304006", "story_v_side_old_103304.awb") ~= 0 then
					local var_26_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304006", "story_v_side_old_103304.awb") / 1000

					if var_26_6 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_0
					end

					if var_26_2.prefab_name ~= "" and arg_23_1.actors_[var_26_2.prefab_name] ~= nil then
						local var_26_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_2.prefab_name].transform, "story_v_side_old_103304", "103304006", "story_v_side_old_103304.awb")

						arg_23_1:RecordAudio("103304006", var_26_7)
						arg_23_1:RecordAudio("103304006", var_26_7)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304006", "story_v_side_old_103304.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304006", "story_v_side_old_103304.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_8 and arg_23_1.time_ < var_26_0 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play103304007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 103304007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play103304008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1033ui_story"]) and arg_27_1.var_.characterEffect1033ui_story == nil then
				arg_27_1.var_.characterEffect1033ui_story = arg_27_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1033ui_story"]) then
				if arg_27_1.var_.characterEffect1033ui_story and not isNil(arg_27_1.actors_["1033ui_story"]) then
					arg_27_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_0)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1033ui_story"]) and arg_27_1.var_.characterEffect1033ui_story then
				arg_27_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_30_1 = 0
			local var_30_2 = 0.125

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
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

				local var_30_3 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(103304007).content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 5 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 5)

				if (5 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 5)) > 0 and var_30_2 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_1
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_6 = math.max(var_30_2, arg_27_1.talkMaxDuration)

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_6 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_1) / var_30_6

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_1 + var_30_6 and arg_27_1.time_ < var_30_1 + var_30_6 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play103304008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 103304008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play103304009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1033ui_story = arg_31_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1033ui_story"].transform.position).z)
				arg_31_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1033ui_story"].transform.localEulerAngles = arg_31_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1033ui_story"].transform.position).z)
				arg_31_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1033ui_story"].transform.localEulerAngles = arg_31_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_button", "")
			end

			local var_34_2 = 0
			local var_34_3 = 0.075

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_4 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(103304008).content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_6 = 3 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_4) / 3)

				if (3 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_4) / 3)) > 0 and var_34_3 < var_34_6 then
					arg_31_1.talkMaxDuration = var_34_6

					if var_34_6 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_6 + var_34_2
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_3, arg_31_1.talkMaxDuration)

			if var_34_2 <= arg_31_1.time_ and arg_31_1.time_ < var_34_2 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_2) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_2 + var_34_7 and arg_31_1.time_ < var_34_2 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
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
	Play103304009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 103304009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play103304010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_start", "")
			end

			local var_38_1 = 0
			local var_38_2 = 1.15

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(103304009).content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 46 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 46)

				if (46 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 46)) > 0 and var_38_2 < var_38_5 then
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
	Play103304010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 103304010
		arg_39_1.duration_ = 5.4

		local var_39_0 = {
			ja = 5.4,
			ko = 3.633,
			zh = 3.066,
			en = 3.5
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
				arg_39_0:Play103304011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.35

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(103304010)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 14 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 14)

				if (14 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 14)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304010", "story_v_side_old_103304.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304010", "story_v_side_old_103304.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_side_old_103304", "103304010", "story_v_side_old_103304.awb")

						arg_39_1:RecordAudio("103304010", var_42_6)
						arg_39_1:RecordAudio("103304010", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304010", "story_v_side_old_103304.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304010", "story_v_side_old_103304.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play103304011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 103304011
		arg_43_1.duration_ = 6.3

		local var_43_0 = {
			ja = 6.3,
			ko = 3.633,
			zh = 2.966,
			en = 3.333
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
				arg_43_0:Play103304012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1033ui_story = arg_43_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1033ui_story"].transform.position).z)
				arg_43_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1033ui_story"].transform.localEulerAngles = arg_43_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_43_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1033ui_story"].transform.position).z)
				arg_43_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1033ui_story"].transform.localEulerAngles = arg_43_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1033ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1033ui_story == nil then
				arg_43_1.var_.characterEffect1033ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1033ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1033ui_story then
				arg_43_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action482")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_46_4 = 0
			local var_46_5 = 0.375

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(103304011)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 15 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 15)

				if (15 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 15)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304011", "story_v_side_old_103304.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304011", "story_v_side_old_103304.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_side_old_103304", "103304011", "story_v_side_old_103304.awb")

						arg_43_1:RecordAudio("103304011", var_46_11)
						arg_43_1:RecordAudio("103304011", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304011", "story_v_side_old_103304.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304011", "story_v_side_old_103304.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play103304012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 103304012
		arg_47_1.duration_ = 17.13

		local var_47_0 = {
			ja = 17.133,
			ko = 10.533,
			zh = 10.533,
			en = 13.5
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
				arg_47_0:Play103304013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1033ui_story"]) and arg_47_1.var_.characterEffect1033ui_story == nil then
				arg_47_1.var_.characterEffect1033ui_story = arg_47_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1033ui_story"]) then
				if arg_47_1.var_.characterEffect1033ui_story and not isNil(arg_47_1.actors_["1033ui_story"]) then
					arg_47_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1033ui_story"]) and arg_47_1.var_.characterEffect1033ui_story then
				arg_47_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 1.1

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:GetWordFromCfg(103304012)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_6 = 44 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_4) / 44)

				if (44 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_4) / 44)) > 0 and var_50_2 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304012", "story_v_side_old_103304.awb") ~= 0 then
					local var_50_7 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304012", "story_v_side_old_103304.awb") / 1000

					if var_50_7 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_1
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_side_old_103304", "103304012", "story_v_side_old_103304.awb")

						arg_47_1:RecordAudio("103304012", var_50_8)
						arg_47_1:RecordAudio("103304012", var_50_8)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304012", "story_v_side_old_103304.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304012", "story_v_side_old_103304.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_9 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_9 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_9

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_9 and arg_47_1.time_ < var_50_1 + var_50_9 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play103304013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 103304013
		arg_51_1.duration_ = 7.07

		local var_51_0 = {
			ja = 7.066,
			ko = 3.533,
			zh = 3.6,
			en = 4.6
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play103304014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.45

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(103304013)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 18 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 18)

				if (18 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 18)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304013", "story_v_side_old_103304.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304013", "story_v_side_old_103304.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_side_old_103304", "103304013", "story_v_side_old_103304.awb")

						arg_51_1:RecordAudio("103304013", var_54_6)
						arg_51_1:RecordAudio("103304013", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304013", "story_v_side_old_103304.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304013", "story_v_side_old_103304.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play103304014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 103304014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play103304015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.95

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(103304014).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 38 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 38)

				if (38 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 38)) > 0 and var_58_0 < var_58_3 then
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
	Play103304015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 103304015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play103304016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.2

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

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(103304015).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 8 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 8)

				if (8 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 8)) > 0 and var_62_0 < var_62_3 then
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
	Play103304016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 103304016
		arg_63_1.duration_ = 4.93

		local var_63_0 = {
			ja = 4.933,
			ko = 4.433,
			zh = 3.466,
			en = 4.933
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play103304017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1033ui_story"]) and arg_63_1.var_.characterEffect1033ui_story == nil then
				arg_63_1.var_.characterEffect1033ui_story = arg_63_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1033ui_story"]) then
				if arg_63_1.var_.characterEffect1033ui_story and not isNil(arg_63_1.actors_["1033ui_story"]) then
					arg_63_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1033ui_story"]) and arg_63_1.var_.characterEffect1033ui_story then
				arg_63_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action423")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_66_2 = 0
			local var_66_3 = 0.425

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_4 = arg_63_1:GetWordFromCfg(103304016)
				local var_66_5 = arg_63_1:FormatText(var_66_4.content)

				arg_63_1.text_.text = var_66_5

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_7 = 17 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 17)

				if (17 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 17)) > 0 and var_66_3 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_5
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304016", "story_v_side_old_103304.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304016", "story_v_side_old_103304.awb") / 1000

					if var_66_8 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_2
					end

					if var_66_4.prefab_name ~= "" and arg_63_1.actors_[var_66_4.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_4.prefab_name].transform, "story_v_side_old_103304", "103304016", "story_v_side_old_103304.awb")

						arg_63_1:RecordAudio("103304016", var_66_9)
						arg_63_1:RecordAudio("103304016", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304016", "story_v_side_old_103304.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304016", "story_v_side_old_103304.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_3, arg_63_1.talkMaxDuration)

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_2) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_2 + var_66_10 and arg_63_1.time_ < var_66_2 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play103304017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 103304017
		arg_67_1.duration_ = 4.9

		local var_67_0 = {
			ja = 4.9,
			ko = 2.5,
			zh = 2.133,
			en = 2.266
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play103304018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1033ui_story"]) and arg_67_1.var_.characterEffect1033ui_story == nil then
				arg_67_1.var_.characterEffect1033ui_story = arg_67_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1033ui_story"]) then
				if arg_67_1.var_.characterEffect1033ui_story and not isNil(arg_67_1.actors_["1033ui_story"]) then
					arg_67_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1033ui_story"]) and arg_67_1.var_.characterEffect1033ui_story then
				arg_67_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(103304017)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 9 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 9)

				if (9 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 9)) > 0 and var_70_2 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304017", "story_v_side_old_103304.awb") ~= 0 then
					local var_70_7 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304017", "story_v_side_old_103304.awb") / 1000

					if var_70_7 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_1
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_side_old_103304", "103304017", "story_v_side_old_103304.awb")

						arg_67_1:RecordAudio("103304017", var_70_8)
						arg_67_1:RecordAudio("103304017", var_70_8)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304017", "story_v_side_old_103304.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304017", "story_v_side_old_103304.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_9 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_9 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_9

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_9 and arg_67_1.time_ < var_70_1 + var_70_9 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play103304018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 103304018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play103304019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1033ui_story = arg_71_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1033ui_story"].transform.position).z)
				arg_71_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1033ui_story"].transform.localEulerAngles = arg_71_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1033ui_story"].transform.position).z)
				arg_71_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1033ui_story"].transform.localEulerAngles = arg_71_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_74_1 = 0
			local var_74_2 = 0.925

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(103304018).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 37 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 37)

				if (37 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 37)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play103304019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 103304019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play103304020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.325

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(103304019).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 13 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 13)

				if (13 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 13)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play103304020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 103304020
		arg_79_1.duration_ = 13.13

		local var_79_0 = {
			ja = 13.133,
			ko = 6.5,
			zh = 5.2,
			en = 8.333
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play103304021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1033ui_story = arg_79_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1033ui_story"].transform.position).z)
				arg_79_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1033ui_story"].transform.localEulerAngles = arg_79_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_79_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1033ui_story"].transform.position).z)
				arg_79_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1033ui_story"].transform.localEulerAngles = arg_79_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1033ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1033ui_story == nil then
				arg_79_1.var_.characterEffect1033ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1033ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1033ui_story then
				arg_79_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action438")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_82_4 = 0
			local var_82_5 = 0.7

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(103304020)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 28 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 28)

				if (28 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 28)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304020", "story_v_side_old_103304.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304020", "story_v_side_old_103304.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_side_old_103304", "103304020", "story_v_side_old_103304.awb")

						arg_79_1:RecordAudio("103304020", var_82_11)
						arg_79_1:RecordAudio("103304020", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304020", "story_v_side_old_103304.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304020", "story_v_side_old_103304.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play103304021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 103304021
		arg_83_1.duration_ = 5.2

		local var_83_0 = {
			ja = 5.2,
			ko = 3.666,
			zh = 3.233,
			en = 4.633
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play103304022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_86_0 = 0
			local var_86_1 = 0.45

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(103304021)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 18 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 18)

				if (18 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 18)) > 0 and var_86_1 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304021", "story_v_side_old_103304.awb") ~= 0 then
					local var_86_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304021", "story_v_side_old_103304.awb") / 1000

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end

					if var_86_2.prefab_name ~= "" and arg_83_1.actors_[var_86_2.prefab_name] ~= nil then
						local var_86_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_2.prefab_name].transform, "story_v_side_old_103304", "103304021", "story_v_side_old_103304.awb")

						arg_83_1:RecordAudio("103304021", var_86_7)
						arg_83_1:RecordAudio("103304021", var_86_7)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304021", "story_v_side_old_103304.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304021", "story_v_side_old_103304.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play103304022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 103304022
		arg_87_1.duration_ = 14.13

		local var_87_0 = {
			ja = 14.133,
			ko = 6.766,
			zh = 6.3,
			en = 8.833
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play103304023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1033ui_story = arg_87_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1033ui_story"].transform.position).z)
				arg_87_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1033ui_story"].transform.localEulerAngles = arg_87_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1033ui_story"].transform.position).z)
				arg_87_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1033ui_story"].transform.localEulerAngles = arg_87_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_90_1 = 0
			local var_90_2 = 0.9

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(103304022)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_6 = 36 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_4) / 36)

				if (36 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_4) / 36)) > 0 and var_90_2 < var_90_6 then
					arg_87_1.talkMaxDuration = var_90_6

					if var_90_6 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304022", "story_v_side_old_103304.awb") ~= 0 then
					local var_90_7 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304022", "story_v_side_old_103304.awb") / 1000

					if var_90_7 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_1
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_side_old_103304", "103304022", "story_v_side_old_103304.awb")

						arg_87_1:RecordAudio("103304022", var_90_8)
						arg_87_1:RecordAudio("103304022", var_90_8)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304022", "story_v_side_old_103304.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304022", "story_v_side_old_103304.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_9 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_9 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_9

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_9 and arg_87_1.time_ < var_90_1 + var_90_9 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play103304023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 103304023
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play103304024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.45

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(103304023).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 18 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 18)

				if (18 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 18)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play103304024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 103304024
		arg_95_1.duration_ = 13.33

		local var_95_0 = {
			ja = 13.333,
			ko = 5.166,
			zh = 4.5,
			en = 5.333
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play103304025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.6

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:GetWordFromCfg(103304024)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 24 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 24)

				if (24 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 24)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304024", "story_v_side_old_103304.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304024", "story_v_side_old_103304.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_side_old_103304", "103304024", "story_v_side_old_103304.awb")

						arg_95_1:RecordAudio("103304024", var_98_6)
						arg_95_1:RecordAudio("103304024", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304024", "story_v_side_old_103304.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304024", "story_v_side_old_103304.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play103304025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 103304025
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play103304026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.7

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(103304025).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 28 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 28)

				if (28 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 28)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play103304026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 103304026
		arg_103_1.duration_ = 3.93

		local var_103_0 = {
			ja = 3.4,
			ko = 3.933,
			zh = 2.9,
			en = 3.6
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play103304027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1033ui_story = arg_103_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1033ui_story"].transform.position).z)
				arg_103_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1033ui_story"].transform.localEulerAngles = arg_103_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_103_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1033ui_story"].transform.position).z)
				arg_103_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1033ui_story"].transform.localEulerAngles = arg_103_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1033ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1033ui_story == nil then
				arg_103_1.var_.characterEffect1033ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1033ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1033ui_story then
				arg_103_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_106_4 = 0
			local var_106_5 = 0.325

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(103304026)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 13 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 13)

				if (13 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 13)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304026", "story_v_side_old_103304.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304026", "story_v_side_old_103304.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_side_old_103304", "103304026", "story_v_side_old_103304.awb")

						arg_103_1:RecordAudio("103304026", var_106_11)
						arg_103_1:RecordAudio("103304026", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304026", "story_v_side_old_103304.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304026", "story_v_side_old_103304.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play103304027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 103304027
		arg_107_1.duration_ = 13.7

		local var_107_0 = {
			ja = 13.7,
			ko = 8.733,
			zh = 7,
			en = 8.533
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play103304028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action423")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_110_0 = 0
			local var_110_1 = 0.975

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(103304027)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 39 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 39)

				if (39 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 39)) > 0 and var_110_1 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304027", "story_v_side_old_103304.awb") ~= 0 then
					local var_110_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304027", "story_v_side_old_103304.awb") / 1000

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end

					if var_110_2.prefab_name ~= "" and arg_107_1.actors_[var_110_2.prefab_name] ~= nil then
						local var_110_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_2.prefab_name].transform, "story_v_side_old_103304", "103304027", "story_v_side_old_103304.awb")

						arg_107_1:RecordAudio("103304027", var_110_7)
						arg_107_1:RecordAudio("103304027", var_110_7)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304027", "story_v_side_old_103304.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304027", "story_v_side_old_103304.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_8 and arg_107_1.time_ < var_110_0 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play103304028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 103304028
		arg_111_1.duration_ = 6.87

		local var_111_0 = {
			ja = 6.866,
			ko = 4.6,
			zh = 3.566,
			en = 4.433
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play103304029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1033ui_story = arg_111_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1033ui_story"].transform.position).z)
				arg_111_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1033ui_story"].transform.localEulerAngles = arg_111_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1033ui_story"].transform.position).z)
				arg_111_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1033ui_story"].transform.localEulerAngles = arg_111_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_114_1 = 0
			local var_114_2 = 0.4

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(103304028)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 16 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 16)

				if (16 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 16)) > 0 and var_114_2 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304028", "story_v_side_old_103304.awb") ~= 0 then
					local var_114_7 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304028", "story_v_side_old_103304.awb") / 1000

					if var_114_7 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_1
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_side_old_103304", "103304028", "story_v_side_old_103304.awb")

						arg_111_1:RecordAudio("103304028", var_114_8)
						arg_111_1:RecordAudio("103304028", var_114_8)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304028", "story_v_side_old_103304.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304028", "story_v_side_old_103304.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_9 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_9 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_9

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_9 and arg_111_1.time_ < var_114_1 + var_114_9 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play103304029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 103304029
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play103304030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.9

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(103304029).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 36 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 36)

				if (36 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 36)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play103304030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 103304030
		arg_119_1.duration_ = 10.93

		local var_119_0 = {
			ja = 10.933,
			ko = 8.633,
			zh = 6.833,
			en = 9.633
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play103304031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.925

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:GetWordFromCfg(103304030)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 37 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 37)

				if (37 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 37)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304030", "story_v_side_old_103304.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304030", "story_v_side_old_103304.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_side_old_103304", "103304030", "story_v_side_old_103304.awb")

						arg_119_1:RecordAudio("103304030", var_122_6)
						arg_119_1:RecordAudio("103304030", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304030", "story_v_side_old_103304.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304030", "story_v_side_old_103304.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play103304031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 103304031
		arg_123_1.duration_ = 13.8

		local var_123_0 = {
			ja = 13.8,
			ko = 12.4,
			zh = 8.866,
			en = 13.766
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play103304032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.125

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:GetWordFromCfg(103304031)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 45 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 45)

				if (45 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 45)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304031", "story_v_side_old_103304.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304031", "story_v_side_old_103304.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_side_old_103304", "103304031", "story_v_side_old_103304.awb")

						arg_123_1:RecordAudio("103304031", var_126_6)
						arg_123_1:RecordAudio("103304031", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304031", "story_v_side_old_103304.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304031", "story_v_side_old_103304.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play103304032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 103304032
		arg_127_1.duration_ = 13.7

		local var_127_0 = {
			ja = 13.7,
			ko = 5.1,
			zh = 4.6,
			en = 6.7
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play103304033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.6

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:GetWordFromCfg(103304032)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 24 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 24)

				if (24 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 24)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304032", "story_v_side_old_103304.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304032", "story_v_side_old_103304.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_side_old_103304", "103304032", "story_v_side_old_103304.awb")

						arg_127_1:RecordAudio("103304032", var_130_6)
						arg_127_1:RecordAudio("103304032", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304032", "story_v_side_old_103304.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304032", "story_v_side_old_103304.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play103304033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 103304033
		arg_131_1.duration_ = 2

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play103304034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1033ui_story = arg_131_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1033ui_story"].transform.position).z)
				arg_131_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1033ui_story"].transform.localEulerAngles = arg_131_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_131_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1033ui_story"].transform.position).z)
				arg_131_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1033ui_story"].transform.localEulerAngles = arg_131_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1033ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1033ui_story == nil then
				arg_131_1.var_.characterEffect1033ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1033ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1033ui_story then
				arg_131_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action438")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_134_4 = 0
			local var_134_5 = 0.05

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(103304033)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 2 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 2)

				if (2 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 2)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304033", "story_v_side_old_103304.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304033", "story_v_side_old_103304.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_side_old_103304", "103304033", "story_v_side_old_103304.awb")

						arg_131_1:RecordAudio("103304033", var_134_11)
						arg_131_1:RecordAudio("103304033", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304033", "story_v_side_old_103304.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304033", "story_v_side_old_103304.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play103304034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 103304034
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play103304035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1033ui_story = arg_135_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1033ui_story"].transform.position).z)
				arg_135_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1033ui_story"].transform.localEulerAngles = arg_135_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1033ui_story"].transform.position).z)
				arg_135_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1033ui_story"].transform.localEulerAngles = arg_135_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_138_1 = 0
			local var_138_2 = 0.825

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(103304034).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 33 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 33)

				if (33 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 33)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_6 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_6 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_6

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_6 and arg_135_1.time_ < var_138_1 + var_138_6 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play103304035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 103304035
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play103304036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.65

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(103304035).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 26 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 26)

				if (26 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 26)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play103304036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 103304036
		arg_143_1.duration_ = 14

		local var_143_0 = {
			ja = 14,
			ko = 12.7,
			zh = 9.766,
			en = 12.7
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play103304037(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.325

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(103304036)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 53 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 53)

				if (53 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 53)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304036", "story_v_side_old_103304.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304036", "story_v_side_old_103304.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_side_old_103304", "103304036", "story_v_side_old_103304.awb")

						arg_143_1:RecordAudio("103304036", var_146_6)
						arg_143_1:RecordAudio("103304036", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304036", "story_v_side_old_103304.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304036", "story_v_side_old_103304.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play103304037 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 103304037
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play103304038(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.75

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(103304037).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 30 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 30)

				if (30 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 30)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play103304038 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 103304038
		arg_151_1.duration_ = 8.4

		local var_151_0 = {
			ja = 8.4,
			ko = 5.9,
			zh = 5.1,
			en = 5.366
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play103304039(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.675

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:GetWordFromCfg(103304038)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 27 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 27)

				if (27 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 27)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304038", "story_v_side_old_103304.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304038", "story_v_side_old_103304.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_side_old_103304", "103304038", "story_v_side_old_103304.awb")

						arg_151_1:RecordAudio("103304038", var_154_6)
						arg_151_1:RecordAudio("103304038", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304038", "story_v_side_old_103304.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304038", "story_v_side_old_103304.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play103304039 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 103304039
		arg_155_1.duration_ = 16.37

		local var_155_0 = {
			ja = 16.366,
			ko = 11.333,
			zh = 8.766,
			en = 14
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play103304040(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 1.175

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(103304039)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 47 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 47)

				if (47 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 47)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304039", "story_v_side_old_103304.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304039", "story_v_side_old_103304.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_side_old_103304", "103304039", "story_v_side_old_103304.awb")

						arg_155_1:RecordAudio("103304039", var_158_6)
						arg_155_1:RecordAudio("103304039", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304039", "story_v_side_old_103304.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304039", "story_v_side_old_103304.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play103304040 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 103304040
		arg_159_1.duration_ = 15.93

		local var_159_0 = {
			ja = 14.266,
			ko = 11.766,
			zh = 10.233,
			en = 15.933
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play103304041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.25

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(103304040)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 50 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 50)

				if (50 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 50)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304040", "story_v_side_old_103304.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304040", "story_v_side_old_103304.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_side_old_103304", "103304040", "story_v_side_old_103304.awb")

						arg_159_1:RecordAudio("103304040", var_162_6)
						arg_159_1:RecordAudio("103304040", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304040", "story_v_side_old_103304.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304040", "story_v_side_old_103304.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play103304041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 103304041
		arg_163_1.duration_ = 2

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play103304042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1033ui_story = arg_163_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).z)
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles = arg_163_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_163_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1033ui_story"].transform.position).z)
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1033ui_story"].transform.localEulerAngles = arg_163_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1033ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1033ui_story == nil then
				arg_163_1.var_.characterEffect1033ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1033ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1033ui_story then
				arg_163_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action482")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_166_4 = 0
			local var_166_5 = 0.05

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(103304041)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 2 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 2)

				if (2 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 2)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304041", "story_v_side_old_103304.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304041", "story_v_side_old_103304.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_side_old_103304", "103304041", "story_v_side_old_103304.awb")

						arg_163_1:RecordAudio("103304041", var_166_11)
						arg_163_1:RecordAudio("103304041", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304041", "story_v_side_old_103304.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304041", "story_v_side_old_103304.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play103304042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 103304042
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play103304043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1033ui_story = arg_167_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1033ui_story"].transform.position).z)
				arg_167_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1033ui_story"].transform.localEulerAngles = arg_167_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1033ui_story"].transform.position).z)
				arg_167_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1033ui_story"].transform.localEulerAngles = arg_167_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_170_1 = 0
			local var_170_2 = 0.375

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(103304042).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 15 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 15)

				if (15 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 15)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play103304043 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 103304043
		arg_171_1.duration_ = 4.03

		local var_171_0 = {
			ja = 4.033,
			ko = 2.733,
			zh = 1.966,
			en = 2.566
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play103304044(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.225

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(103304043)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 9 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 9)

				if (9 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 9)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304043", "story_v_side_old_103304.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304043", "story_v_side_old_103304.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_side_old_103304", "103304043", "story_v_side_old_103304.awb")

						arg_171_1:RecordAudio("103304043", var_174_6)
						arg_171_1:RecordAudio("103304043", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304043", "story_v_side_old_103304.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304043", "story_v_side_old_103304.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play103304044 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 103304044
		arg_175_1.duration_ = 18.17

		local var_175_0 = {
			ja = 18.166,
			ko = 10.5,
			zh = 9.133,
			en = 14.5
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play103304045(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 1.275

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(103304044)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 51 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 51)

				if (51 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 51)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304044", "story_v_side_old_103304.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304044", "story_v_side_old_103304.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_side_old_103304", "103304044", "story_v_side_old_103304.awb")

						arg_175_1:RecordAudio("103304044", var_178_6)
						arg_175_1:RecordAudio("103304044", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304044", "story_v_side_old_103304.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304044", "story_v_side_old_103304.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play103304045 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 103304045
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play103304046(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.775

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(103304045).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 31 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 31)

				if (31 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 31)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play103304046 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 103304046
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play103304047(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.725

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(103304046).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 29 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 29)

				if (29 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 29)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play103304047 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 103304047
		arg_187_1.duration_ = 2

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play103304048(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1033ui_story = arg_187_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1033ui_story"].transform.position).z)
				arg_187_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1033ui_story"].transform.localEulerAngles = arg_187_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_187_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1033ui_story"].transform.position).z)
				arg_187_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1033ui_story"].transform.localEulerAngles = arg_187_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["1033ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1033ui_story == nil then
				arg_187_1.var_.characterEffect1033ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect1033ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1033ui_story then
				arg_187_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action428")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_190_4 = 0
			local var_190_5 = 0.2

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(103304047)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 8 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 8)

				if (8 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 8)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304047", "story_v_side_old_103304.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304047", "story_v_side_old_103304.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_side_old_103304", "103304047", "story_v_side_old_103304.awb")

						arg_187_1:RecordAudio("103304047", var_190_11)
						arg_187_1:RecordAudio("103304047", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304047", "story_v_side_old_103304.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304047", "story_v_side_old_103304.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play103304048 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 103304048
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play103304049(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1033ui_story"]) and arg_191_1.var_.characterEffect1033ui_story == nil then
				arg_191_1.var_.characterEffect1033ui_story = arg_191_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1033ui_story"]) then
				if arg_191_1.var_.characterEffect1033ui_story and not isNil(arg_191_1.actors_["1033ui_story"]) then
					arg_191_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1033ui_story"]) and arg_191_1.var_.characterEffect1033ui_story then
				arg_191_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.125

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(103304048).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 5 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 5)

				if (5 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 5)) > 0 and var_194_2 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_6 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_6 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_6

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_6 and arg_191_1.time_ < var_194_1 + var_194_6 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play103304049 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 103304049
		arg_195_1.duration_ = 3.83

		local var_195_0 = {
			ja = 3.833,
			ko = 3,
			zh = 3,
			en = 2.566
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play103304050(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1033ui_story"]) and arg_195_1.var_.characterEffect1033ui_story == nil then
				arg_195_1.var_.characterEffect1033ui_story = arg_195_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1033ui_story"]) then
				if arg_195_1.var_.characterEffect1033ui_story and not isNil(arg_195_1.actors_["1033ui_story"]) then
					arg_195_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1033ui_story"]) and arg_195_1.var_.characterEffect1033ui_story then
				arg_195_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_198_2 = 0
			local var_198_3 = 0.275

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:GetWordFromCfg(103304049)
				local var_198_5 = arg_195_1:FormatText(var_198_4.content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 11 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 11)

				if (11 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 11)) > 0 and var_198_3 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_2
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304049", "story_v_side_old_103304.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304049", "story_v_side_old_103304.awb") / 1000

					if var_198_8 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_2
					end

					if var_198_4.prefab_name ~= "" and arg_195_1.actors_[var_198_4.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_4.prefab_name].transform, "story_v_side_old_103304", "103304049", "story_v_side_old_103304.awb")

						arg_195_1:RecordAudio("103304049", var_198_9)
						arg_195_1:RecordAudio("103304049", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304049", "story_v_side_old_103304.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304049", "story_v_side_old_103304.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_3, arg_195_1.talkMaxDuration)

			if var_198_2 <= arg_195_1.time_ and arg_195_1.time_ < var_198_2 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_2) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_2 + var_198_10 and arg_195_1.time_ < var_198_2 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play103304050 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 103304050
		arg_199_1.duration_ = 3.87

		local var_199_0 = {
			ja = 3.866,
			ko = 3.533,
			zh = 3.6,
			en = 3.2
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play103304051(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1033ui_story = arg_199_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1033ui_story"].transform.position).z)
				arg_199_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1033ui_story"].transform.localEulerAngles = arg_199_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1033ui_story"].transform.position).z)
				arg_199_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1033ui_story"].transform.localEulerAngles = arg_199_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_202_1 = 0
			local var_202_2 = 0.375

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(103304050)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 15 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 15)

				if (15 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 15)) > 0 and var_202_2 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304050", "story_v_side_old_103304.awb") ~= 0 then
					local var_202_7 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304050", "story_v_side_old_103304.awb") / 1000

					if var_202_7 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_1
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_side_old_103304", "103304050", "story_v_side_old_103304.awb")

						arg_199_1:RecordAudio("103304050", var_202_8)
						arg_199_1:RecordAudio("103304050", var_202_8)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304050", "story_v_side_old_103304.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304050", "story_v_side_old_103304.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_9 and arg_199_1.time_ < var_202_1 + var_202_9 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play103304051 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 103304051
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play103304052(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_dormancy", "")
			end

			local var_206_1 = 0
			local var_206_2 = 1.1

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(103304051).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 44 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 44)

				if (44 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 44)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play103304052 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 103304052
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play103304053(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.225

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(103304052).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 9 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 9)

				if (9 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 9)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play103304053 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 103304053
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play103304054(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.725

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(103304053).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 29 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 29)

				if (29 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 29)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play103304054 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 103304054
		arg_215_1.duration_ = 8.7

		local var_215_0 = {
			ja = 8.7,
			ko = 8.1,
			zh = 6.4,
			en = 4.866
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play103304055(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1033ui_story = arg_215_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1033ui_story"].transform.position).z)
				arg_215_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1033ui_story"].transform.localEulerAngles = arg_215_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_215_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1033ui_story"].transform.position).z)
				arg_215_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1033ui_story"].transform.localEulerAngles = arg_215_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1033ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1033ui_story == nil then
				arg_215_1.var_.characterEffect1033ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1033ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1033ui_story then
				arg_215_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action483")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_218_4 = 0
			local var_218_5 = 0.75

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(103304054)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 30 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 30)

				if (30 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 30)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304054", "story_v_side_old_103304.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304054", "story_v_side_old_103304.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_side_old_103304", "103304054", "story_v_side_old_103304.awb")

						arg_215_1:RecordAudio("103304054", var_218_11)
						arg_215_1:RecordAudio("103304054", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304054", "story_v_side_old_103304.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304054", "story_v_side_old_103304.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play103304055 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 103304055
		arg_219_1.duration_ = 13.17

		local var_219_0 = {
			ja = 13.166,
			ko = 12.7,
			zh = 10,
			en = 9.566
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play103304056(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_222_0 = 0
			local var_222_1 = 1.125

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(103304055)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 45 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 45)

				if (45 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 45)) > 0 and var_222_1 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304055", "story_v_side_old_103304.awb") ~= 0 then
					local var_222_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304055", "story_v_side_old_103304.awb") / 1000

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end

					if var_222_2.prefab_name ~= "" and arg_219_1.actors_[var_222_2.prefab_name] ~= nil then
						local var_222_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_2.prefab_name].transform, "story_v_side_old_103304", "103304055", "story_v_side_old_103304.awb")

						arg_219_1:RecordAudio("103304055", var_222_7)
						arg_219_1:RecordAudio("103304055", var_222_7)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304055", "story_v_side_old_103304.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304055", "story_v_side_old_103304.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play103304056 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 103304056
		arg_223_1.duration_ = 18.83

		local var_223_0 = {
			ja = 18.833,
			ko = 14.333,
			zh = 11.666,
			en = 13.166
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play103304057(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_226_0 = 0
			local var_226_1 = 1.4

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(103304056)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 56 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_3) / 56)

				if (56 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_3) / 56)) > 0 and var_226_1 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304056", "story_v_side_old_103304.awb") ~= 0 then
					local var_226_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304056", "story_v_side_old_103304.awb") / 1000

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end

					if var_226_2.prefab_name ~= "" and arg_223_1.actors_[var_226_2.prefab_name] ~= nil then
						local var_226_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_2.prefab_name].transform, "story_v_side_old_103304", "103304056", "story_v_side_old_103304.awb")

						arg_223_1:RecordAudio("103304056", var_226_7)
						arg_223_1:RecordAudio("103304056", var_226_7)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304056", "story_v_side_old_103304.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304056", "story_v_side_old_103304.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_8 and arg_223_1.time_ < var_226_0 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play103304057 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 103304057
		arg_227_1.duration_ = 17.43

		local var_227_0 = {
			ja = 17.433,
			ko = 15.7,
			zh = 13.933,
			en = 16.333
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play103304058(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action438")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_230_0 = 0
			local var_230_1 = 1.525

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(103304057)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 61 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 61)

				if (61 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 61)) > 0 and var_230_1 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304057", "story_v_side_old_103304.awb") ~= 0 then
					local var_230_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304057", "story_v_side_old_103304.awb") / 1000

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end

					if var_230_2.prefab_name ~= "" and arg_227_1.actors_[var_230_2.prefab_name] ~= nil then
						local var_230_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_2.prefab_name].transform, "story_v_side_old_103304", "103304057", "story_v_side_old_103304.awb")

						arg_227_1:RecordAudio("103304057", var_230_7)
						arg_227_1:RecordAudio("103304057", var_230_7)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304057", "story_v_side_old_103304.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304057", "story_v_side_old_103304.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_8 and arg_227_1.time_ < var_230_0 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play103304058 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 103304058
		arg_231_1.duration_ = 15.67

		local var_231_0 = {
			ja = 15.666,
			ko = 10.966,
			zh = 10,
			en = 9.733
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play103304059(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_234_0 = 0
			local var_234_1 = 0.975

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_2 = arg_231_1:GetWordFromCfg(103304058)
				local var_234_3 = arg_231_1:FormatText(var_234_2.content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 39 <= 0 and var_234_1 or var_234_1 * (utf8.len(var_234_3) / 39)

				if (39 <= 0 and var_234_1 or var_234_1 * (utf8.len(var_234_3) / 39)) > 0 and var_234_1 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304058", "story_v_side_old_103304.awb") ~= 0 then
					local var_234_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304058", "story_v_side_old_103304.awb") / 1000

					if var_234_6 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_0
					end

					if var_234_2.prefab_name ~= "" and arg_231_1.actors_[var_234_2.prefab_name] ~= nil then
						local var_234_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_2.prefab_name].transform, "story_v_side_old_103304", "103304058", "story_v_side_old_103304.awb")

						arg_231_1:RecordAudio("103304058", var_234_7)
						arg_231_1:RecordAudio("103304058", var_234_7)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304058", "story_v_side_old_103304.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304058", "story_v_side_old_103304.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_8 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_8 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_8

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_8 and arg_231_1.time_ < var_234_0 + var_234_8 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play103304059 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 103304059
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play103304060(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1033ui_story = arg_235_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1033ui_story"].transform.position).z)
				arg_235_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1033ui_story"].transform.localEulerAngles = arg_235_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1033ui_story"].transform.position).z)
				arg_235_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1033ui_story"].transform.localEulerAngles = arg_235_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_238_1 = 0
			local var_238_2 = 0.55

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(103304059).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 22 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 22)

				if (22 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 22)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play103304060 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 103304060
		arg_239_1.duration_ = 9.83

		local var_239_0 = {
			ja = 9.833,
			ko = 6.433,
			zh = 5.933,
			en = 5.7
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play103304061(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1033ui_story = arg_239_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1033ui_story"].transform.position).z)
				arg_239_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1033ui_story"].transform.localEulerAngles = arg_239_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_239_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1033ui_story"].transform.position).z)
				arg_239_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1033ui_story"].transform.localEulerAngles = arg_239_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1033ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1033ui_story == nil then
				arg_239_1.var_.characterEffect1033ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1033ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1033ui_story then
				arg_239_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_2")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_242_4 = 0
			local var_242_5 = 0.45

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(103304060)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 18 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 18)

				if (18 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 18)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304060", "story_v_side_old_103304.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304060", "story_v_side_old_103304.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_side_old_103304", "103304060", "story_v_side_old_103304.awb")

						arg_239_1:RecordAudio("103304060", var_242_11)
						arg_239_1:RecordAudio("103304060", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304060", "story_v_side_old_103304.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304060", "story_v_side_old_103304.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play103304061 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 103304061
		arg_243_1.duration_ = 7

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play103304062(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				local var_246_0 = arg_243_1.bgs_.ST18

				arg_243_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_246_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_1 = var_246_0:GetComponent("SpriteRenderer")

				if var_246_1 and var_246_1.sprite then
					local var_246_2 = 2 * (var_246_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_246_0.transform.localScale = Vector3.New(var_246_2 / var_246_1.sprite.bounds.size.y < var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x and var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x or var_246_2 / var_246_1.sprite.bounds.size.y, var_246_2 / var_246_1.sprite.bounds.size.y < var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x and var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x or var_246_2 / var_246_1.sprite.bounds.size.y, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "ST18" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_3 = "B03e"

			if arg_243_1.bgs_.B03e == nil then
				local var_246_4 = Object.Instantiate(arg_243_1.paintGo_)

				var_246_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_246_3)
				var_246_4.name = var_246_3
				var_246_4.transform.parent = arg_243_1.stage_.transform
				var_246_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.bgs_[var_246_3] = var_246_4
			end

			if 1 < arg_243_1.time_ and arg_243_1.time_ <= 1 + arg_246_0 then
				local var_246_5 = arg_243_1.bgs_.B03e

				arg_243_1.bgs_.B03e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_246_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_6 = var_246_5:GetComponent("SpriteRenderer")

				if var_246_6 and var_246_6.sprite then
					local var_246_7 = 2 * (var_246_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_246_5.transform.localScale = Vector3.New(var_246_7 / var_246_6.sprite.bounds.size.y < var_246_7 * manager.ui.mainCameraCom_.aspect / var_246_6.sprite.bounds.size.x and var_246_7 * manager.ui.mainCameraCom_.aspect / var_246_6.sprite.bounds.size.x or var_246_7 / var_246_6.sprite.bounds.size.y, var_246_7 / var_246_6.sprite.bounds.size.y < var_246_7 * manager.ui.mainCameraCom_.aspect / var_246_6.sprite.bounds.size.x and var_246_7 * manager.ui.mainCameraCom_.aspect / var_246_6.sprite.bounds.size.x or var_246_7 / var_246_6.sprite.bounds.size.y, 0)
				end

				for iter_246_2, iter_246_3 in pairs(arg_243_1.bgs_) do
					if iter_246_2 ~= "B03e" then
						iter_246_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_8 = 0

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = false

				arg_243_1:SetGaussion(false)
			end

			local var_246_9 = 1

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_9 then
				local var_246_10 = Color.New(0, 0, 0)

				var_246_10.a = Mathf.Lerp(0, 1, (arg_243_1.time_ - var_246_8) / var_246_9)
				arg_243_1.mask_.color = var_246_10
			end

			if arg_243_1.time_ >= var_246_8 + var_246_9 and arg_243_1.time_ < var_246_8 + var_246_9 + arg_246_0 then
				local var_246_11 = Color.New(0, 0, 0)

				var_246_11.a = 1
				arg_243_1.mask_.color = var_246_11
			end

			local var_246_12 = 1

			if 1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_12 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = false

				arg_243_1:SetGaussion(false)
			end

			local var_246_13 = 1

			if var_246_12 <= arg_243_1.time_ and arg_243_1.time_ < var_246_12 + var_246_13 then
				local var_246_14 = Color.New(0, 0, 0)

				var_246_14.a = Mathf.Lerp(1, 0, (arg_243_1.time_ - var_246_12) / var_246_13)
				arg_243_1.mask_.color = var_246_14
			end

			if arg_243_1.time_ >= var_246_12 + var_246_13 and arg_243_1.time_ < var_246_12 + var_246_13 + arg_246_0 then
				local var_246_15 = Color.New(0, 0, 0)

				arg_243_1.mask_.enabled = false
				var_246_15.a = 0
				arg_243_1.mask_.color = var_246_15
			end

			local var_246_16 = arg_243_1.actors_["1033ui_story"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1033ui_story = var_246_16.localPosition
			end

			local var_246_17 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_17 then
				var_246_16.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_17)
				var_246_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_16.position).x, (manager.ui.mainCamera.transform.position - var_246_16.position).y, (manager.ui.mainCamera.transform.position - var_246_16.position).z)
				var_246_16.localEulerAngles.z = 0
				var_246_16.localEulerAngles.x = 0
				var_246_16.localEulerAngles = var_246_16.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_17 and arg_243_1.time_ < 0 + var_246_17 + arg_246_0 then
				var_246_16.localPosition = Vector3.New(0, 100, 0)
				var_246_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_16.position).x, (manager.ui.mainCamera.transform.position - var_246_16.position).y, (manager.ui.mainCamera.transform.position - var_246_16.position).z)
				var_246_16.localEulerAngles.z = 0
				var_246_16.localEulerAngles.x = 0
				var_246_16.localEulerAngles = var_246_16.localEulerAngles
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_18 = 2
			local var_246_19 = 0.95

			if 2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_18 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_20 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_20:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_21 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(103304061).content)

				arg_243_1.text_.text = var_246_21

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_23 = 38 <= 0 and var_246_19 or var_246_19 * (utf8.len(var_246_21) / 38)

				if (38 <= 0 and var_246_19 or var_246_19 * (utf8.len(var_246_21) / 38)) > 0 and var_246_19 < var_246_23 then
					arg_243_1.talkMaxDuration = var_246_23
					var_246_18 = var_246_18 + 0.3

					if var_246_23 + var_246_18 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_18
					end
				end

				arg_243_1.text_.text = var_246_21
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_24 = var_246_18 + 0.3
			local var_246_25 = math.max(var_246_19, arg_243_1.talkMaxDuration)

			if var_246_18 + 0.3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_24 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_24) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_24 + var_246_25 and arg_243_1.time_ < var_246_24 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play103304062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 103304062
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play103304063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 1.15

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(103304062).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 46 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 46)

				if (46 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 46)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play103304063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 103304063
		arg_253_1.duration_ = 10.1

		local var_253_0 = {
			ja = 10.1,
			ko = 7,
			zh = 6,
			en = 8.8
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play103304064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.625

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(103304063)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 25 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 25)

				if (25 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 25)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304063", "story_v_side_old_103304.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304063", "story_v_side_old_103304.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_side_old_103304", "103304063", "story_v_side_old_103304.awb")

						arg_253_1:RecordAudio("103304063", var_256_6)
						arg_253_1:RecordAudio("103304063", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304063", "story_v_side_old_103304.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304063", "story_v_side_old_103304.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play103304064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 103304064
		arg_257_1.duration_ = 4.3

		local var_257_0 = {
			ja = 4.3,
			ko = 3.6,
			zh = 3.033,
			en = 3.8
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play103304065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.375

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(103304064)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 15 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 15)

				if (15 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 15)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304064", "story_v_side_old_103304.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304064", "story_v_side_old_103304.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_side_old_103304", "103304064", "story_v_side_old_103304.awb")

						arg_257_1:RecordAudio("103304064", var_260_6)
						arg_257_1:RecordAudio("103304064", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304064", "story_v_side_old_103304.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304064", "story_v_side_old_103304.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play103304065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 103304065
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play103304066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.5

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(103304065).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 20 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 20)

				if (20 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 20)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play103304066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 103304066
		arg_265_1.duration_ = 4.6

		local var_265_0 = {
			ja = 4.6,
			ko = 4.2,
			zh = 3.266,
			en = 3.533
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play103304067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1033ui_story = arg_265_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).z)
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles = arg_265_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_265_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1033ui_story"].transform.position).z)
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1033ui_story"].transform.localEulerAngles = arg_265_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1033ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1033ui_story == nil then
				arg_265_1.var_.characterEffect1033ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1033ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1033ui_story then
				arg_265_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_268_4 = 0
			local var_268_5 = 0.475

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(103304066)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 19 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 19)

				if (19 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 19)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304066", "story_v_side_old_103304.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304066", "story_v_side_old_103304.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_side_old_103304", "103304066", "story_v_side_old_103304.awb")

						arg_265_1:RecordAudio("103304066", var_268_11)
						arg_265_1:RecordAudio("103304066", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304066", "story_v_side_old_103304.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304066", "story_v_side_old_103304.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play103304067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 103304067
		arg_269_1.duration_ = 3.9

		local var_269_0 = {
			ja = 3.9,
			ko = 2,
			zh = 2.266,
			en = 2.566
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play103304068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_272_0 = 0
			local var_272_1 = 0.25

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_2 = arg_269_1:GetWordFromCfg(103304067)
				local var_272_3 = arg_269_1:FormatText(var_272_2.content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 10 <= 0 and var_272_1 or var_272_1 * (utf8.len(var_272_3) / 10)

				if (10 <= 0 and var_272_1 or var_272_1 * (utf8.len(var_272_3) / 10)) > 0 and var_272_1 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304067", "story_v_side_old_103304.awb") ~= 0 then
					local var_272_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304067", "story_v_side_old_103304.awb") / 1000

					if var_272_6 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_0
					end

					if var_272_2.prefab_name ~= "" and arg_269_1.actors_[var_272_2.prefab_name] ~= nil then
						local var_272_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_2.prefab_name].transform, "story_v_side_old_103304", "103304067", "story_v_side_old_103304.awb")

						arg_269_1:RecordAudio("103304067", var_272_7)
						arg_269_1:RecordAudio("103304067", var_272_7)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304067", "story_v_side_old_103304.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304067", "story_v_side_old_103304.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_8 and arg_269_1.time_ < var_272_0 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play103304068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 103304068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play103304069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1033ui_story = arg_273_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1033ui_story"].transform.position).z)
				arg_273_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1033ui_story"].transform.localEulerAngles = arg_273_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1033ui_story"].transform.position).z)
				arg_273_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1033ui_story"].transform.localEulerAngles = arg_273_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0.716666666666667 < arg_273_1.time_ and arg_273_1.time_ <= 0.716666666666667 + arg_276_0 then
				arg_273_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_door", "")
			end

			local var_276_2 = 0
			local var_276_3 = 0.925

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_4 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(103304068).content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 37 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_4) / 37)

				if (37 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_4) / 37)) > 0 and var_276_3 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_2
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_3, arg_273_1.talkMaxDuration)

			if var_276_2 <= arg_273_1.time_ and arg_273_1.time_ < var_276_2 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_2) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_2 + var_276_7 and arg_273_1.time_ < var_276_2 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play103304069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 103304069
		arg_277_1.duration_ = 4.2

		local var_277_0 = {
			ja = 4.2,
			ko = 3.833,
			zh = 3.266,
			en = 3.166
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play103304070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.375

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(103304069)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 15 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 15)

				if (15 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 15)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304069", "story_v_side_old_103304.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304069", "story_v_side_old_103304.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_side_old_103304", "103304069", "story_v_side_old_103304.awb")

						arg_277_1:RecordAudio("103304069", var_280_6)
						arg_277_1:RecordAudio("103304069", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304069", "story_v_side_old_103304.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304069", "story_v_side_old_103304.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play103304070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 103304070
		arg_281_1.duration_ = 2.67

		local var_281_0 = {
			ja = 2.666,
			ko = 1.7,
			zh = 1.233,
			en = 1.633
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play103304071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.15

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:GetWordFromCfg(103304070)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 6 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 6)

				if (6 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 6)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304070", "story_v_side_old_103304.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304070", "story_v_side_old_103304.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_side_old_103304", "103304070", "story_v_side_old_103304.awb")

						arg_281_1:RecordAudio("103304070", var_284_6)
						arg_281_1:RecordAudio("103304070", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304070", "story_v_side_old_103304.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304070", "story_v_side_old_103304.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play103304071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 103304071
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play103304072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.9

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(103304071).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 36 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 36)

				if (36 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 36)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play103304072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 103304072
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play103304073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.05

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(103304072).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 42 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 42)

				if (42 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 42)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play103304073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 103304073
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play103304074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.025

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(103304073).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 41 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 41)

				if (41 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 41)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play103304074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 103304074
		arg_297_1.duration_ = 2.93

		local var_297_0 = {
			ja = 2.933,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play103304075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1033ui_story = arg_297_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).z)
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles = arg_297_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_297_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1033ui_story"].transform.position).z)
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1033ui_story"].transform.localEulerAngles = arg_297_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1033ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1033ui_story == nil then
				arg_297_1.var_.characterEffect1033ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect1033ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1033ui_story then
				arg_297_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_2")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_300_4 = 0
			local var_300_5 = 0.125

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(103304074)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 5 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 5)

				if (5 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 5)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304074", "story_v_side_old_103304.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304074", "story_v_side_old_103304.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_side_old_103304", "103304074", "story_v_side_old_103304.awb")

						arg_297_1:RecordAudio("103304074", var_300_11)
						arg_297_1:RecordAudio("103304074", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304074", "story_v_side_old_103304.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304074", "story_v_side_old_103304.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play103304075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 103304075
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play103304076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1033ui_story = arg_301_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1033ui_story"].transform.position).z)
				arg_301_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1033ui_story"].transform.localEulerAngles = arg_301_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1033ui_story"].transform.position).z)
				arg_301_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1033ui_story"].transform.localEulerAngles = arg_301_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_304_1 = 0
			local var_304_2 = 1.075

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(103304075).content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 43 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 43)

				if (43 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 43)) > 0 and var_304_2 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_6 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_6 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_6

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_6 and arg_301_1.time_ < var_304_1 + var_304_6 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play103304076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 103304076
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play103304077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.875

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(103304076).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 35 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 35)

				if (35 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 35)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play103304077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 103304077
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play103304078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.425

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(103304077).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 17 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 17)

				if (17 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 17)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play103304078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 103304078
		arg_313_1.duration_ = 15.57

		local var_313_0 = {
			ja = 15.566,
			ko = 8.366,
			zh = 6.433,
			en = 8.8
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play103304079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1033ui_story = arg_313_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1033ui_story"].transform.position).z)
				arg_313_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1033ui_story"].transform.localEulerAngles = arg_313_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_313_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1033ui_story"].transform.position).z)
				arg_313_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1033ui_story"].transform.localEulerAngles = arg_313_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1033ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1033ui_story == nil then
				arg_313_1.var_.characterEffect1033ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1033ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1033ui_story then
				arg_313_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_316_4 = 0
			local var_316_5 = 0.8

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(103304078)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 32 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 32)

				if (32 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 32)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304078", "story_v_side_old_103304.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304078", "story_v_side_old_103304.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_old_103304", "103304078", "story_v_side_old_103304.awb")

						arg_313_1:RecordAudio("103304078", var_316_11)
						arg_313_1:RecordAudio("103304078", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304078", "story_v_side_old_103304.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304078", "story_v_side_old_103304.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play103304079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 103304079
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play103304080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1033ui_story = arg_317_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).z)
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles = arg_317_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1033ui_story"].transform.position).z)
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1033ui_story"].transform.localEulerAngles = arg_317_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_320_1 = 0
			local var_320_2 = 1.1

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(103304079).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 44 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 44)

				if (44 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 44)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play103304080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 103304080
		arg_321_1.duration_ = 5.73

		local var_321_0 = {
			ja = 5.733,
			ko = 2.533,
			zh = 1.999999999999,
			en = 3.5
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play103304081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1033ui_story = arg_321_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).z)
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles = arg_321_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_321_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1033ui_story"].transform.position).z)
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1033ui_story"].transform.localEulerAngles = arg_321_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1033ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1033ui_story == nil then
				arg_321_1.var_.characterEffect1033ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1033ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1033ui_story then
				arg_321_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_324_4 = 0
			local var_324_5 = 0.225

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(103304080)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 9 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 9)

				if (9 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 9)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304080", "story_v_side_old_103304.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304080", "story_v_side_old_103304.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_side_old_103304", "103304080", "story_v_side_old_103304.awb")

						arg_321_1:RecordAudio("103304080", var_324_11)
						arg_321_1:RecordAudio("103304080", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304080", "story_v_side_old_103304.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304080", "story_v_side_old_103304.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play103304081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 103304081
		arg_325_1.duration_ = 6.7

		local var_325_0 = {
			ja = 6.7,
			ko = 5.5,
			zh = 4.133,
			en = 4.933
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play103304082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action438")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_328_0 = 0
			local var_328_1 = 0.45

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_2 = arg_325_1:GetWordFromCfg(103304081)
				local var_328_3 = arg_325_1:FormatText(var_328_2.content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 18 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_3) / 18)

				if (18 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_3) / 18)) > 0 and var_328_1 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304081", "story_v_side_old_103304.awb") ~= 0 then
					local var_328_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304081", "story_v_side_old_103304.awb") / 1000

					if var_328_6 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_0
					end

					if var_328_2.prefab_name ~= "" and arg_325_1.actors_[var_328_2.prefab_name] ~= nil then
						local var_328_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_2.prefab_name].transform, "story_v_side_old_103304", "103304081", "story_v_side_old_103304.awb")

						arg_325_1:RecordAudio("103304081", var_328_7)
						arg_325_1:RecordAudio("103304081", var_328_7)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304081", "story_v_side_old_103304.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304081", "story_v_side_old_103304.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_8 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_8

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_8 and arg_325_1.time_ < var_328_0 + var_328_8 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play103304082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 103304082
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play103304083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1033ui_story = arg_329_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1033ui_story"].transform.position).z)
				arg_329_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1033ui_story"].transform.localEulerAngles = arg_329_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1033ui_story"].transform.position).z)
				arg_329_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1033ui_story"].transform.localEulerAngles = arg_329_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_332_1 = 0
			local var_332_2 = 1.175

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(103304082).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 47 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 47)

				if (47 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 47)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play103304083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 103304083
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play103304084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.85

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(103304083).content)

				arg_333_1.text_.text = var_336_1

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_3 = 34 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 34)

				if (34 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 34)) > 0 and var_336_0 < var_336_3 then
					arg_333_1.talkMaxDuration = var_336_3

					if var_336_3 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_3 + 0
					end
				end

				arg_333_1.text_.text = var_336_1
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_4 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_4

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play103304084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 103304084
		arg_337_1.duration_ = 9.73

		local var_337_0 = {
			ja = 9.733,
			ko = 9.1,
			zh = 5.7,
			en = 9.6
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play103304085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.65

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_1 = arg_337_1:GetWordFromCfg(103304084)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 26 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 26)

				if (26 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 26)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304084", "story_v_side_old_103304.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304084", "story_v_side_old_103304.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_side_old_103304", "103304084", "story_v_side_old_103304.awb")

						arg_337_1:RecordAudio("103304084", var_340_6)
						arg_337_1:RecordAudio("103304084", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304084", "story_v_side_old_103304.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304084", "story_v_side_old_103304.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play103304085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 103304085
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play103304086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 1.025

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(103304085).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 41 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 41)

				if (41 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 41)) > 0 and var_344_0 < var_344_3 then
					arg_341_1.talkMaxDuration = var_344_3

					if var_344_3 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_3 + 0
					end
				end

				arg_341_1.text_.text = var_344_1
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_4 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_4

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play103304086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 103304086
		arg_345_1.duration_ = 7

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play103304087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				local var_348_0 = arg_345_1.bgs_.B03e

				arg_345_1.bgs_.B03e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_348_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_1 = var_348_0:GetComponent("SpriteRenderer")

				if var_348_1 and var_348_1.sprite then
					local var_348_2 = 2 * (var_348_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_348_0.transform.localScale = Vector3.New(var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "B03e" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_3 = "B03d"

			if arg_345_1.bgs_.B03d == nil then
				local var_348_4 = Object.Instantiate(arg_345_1.paintGo_)

				var_348_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_348_3)
				var_348_4.name = var_348_3
				var_348_4.transform.parent = arg_345_1.stage_.transform
				var_348_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.bgs_[var_348_3] = var_348_4
			end

			if 1.025 < arg_345_1.time_ and arg_345_1.time_ <= 1.025 + arg_348_0 then
				local var_348_5 = arg_345_1.bgs_.B03d

				arg_345_1.bgs_.B03d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_348_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_6 = var_348_5:GetComponent("SpriteRenderer")

				if var_348_6 and var_348_6.sprite then
					local var_348_7 = 2 * (var_348_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_348_5.transform.localScale = Vector3.New(var_348_7 / var_348_6.sprite.bounds.size.y < var_348_7 * manager.ui.mainCameraCom_.aspect / var_348_6.sprite.bounds.size.x and var_348_7 * manager.ui.mainCameraCom_.aspect / var_348_6.sprite.bounds.size.x or var_348_7 / var_348_6.sprite.bounds.size.y, var_348_7 / var_348_6.sprite.bounds.size.y < var_348_7 * manager.ui.mainCameraCom_.aspect / var_348_6.sprite.bounds.size.x and var_348_7 * manager.ui.mainCameraCom_.aspect / var_348_6.sprite.bounds.size.x or var_348_7 / var_348_6.sprite.bounds.size.y, 0)
				end

				for iter_348_2, iter_348_3 in pairs(arg_345_1.bgs_) do
					if iter_348_2 ~= "B03d" then
						iter_348_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_8 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = false

				arg_345_1:SetGaussion(false)
			end

			local var_348_9 = 1.025

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 then
				local var_348_10 = Color.New(0, 0, 0)

				var_348_10.a = Mathf.Lerp(0, 1, (arg_345_1.time_ - var_348_8) / var_348_9)
				arg_345_1.mask_.color = var_348_10
			end

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 then
				local var_348_11 = Color.New(0, 0, 0)

				var_348_11.a = 1
				arg_345_1.mask_.color = var_348_11
			end

			local var_348_12 = 1.025

			if 1.025 < arg_345_1.time_ and arg_345_1.time_ <= var_348_12 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = false

				arg_345_1:SetGaussion(false)
			end

			local var_348_13 = 0.975

			if var_348_12 <= arg_345_1.time_ and arg_345_1.time_ < var_348_12 + var_348_13 then
				local var_348_14 = Color.New(0, 0, 0)

				var_348_14.a = Mathf.Lerp(1, 0, (arg_345_1.time_ - var_348_12) / var_348_13)
				arg_345_1.mask_.color = var_348_14
			end

			if arg_345_1.time_ >= var_348_12 + var_348_13 and arg_345_1.time_ < var_348_12 + var_348_13 + arg_348_0 then
				local var_348_15 = Color.New(0, 0, 0)

				arg_345_1.mask_.enabled = false
				var_348_15.a = 0
				arg_345_1.mask_.color = var_348_15
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_16 = 2
			local var_348_17 = 0.05

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_18 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_18:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_19 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(103304086).content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_21 = 2 <= 0 and var_348_17 or var_348_17 * (utf8.len(var_348_19) / 2)

				if (2 <= 0 and var_348_17 or var_348_17 * (utf8.len(var_348_19) / 2)) > 0 and var_348_17 < var_348_21 then
					arg_345_1.talkMaxDuration = var_348_21
					var_348_16 = var_348_16 + 0.3

					if var_348_21 + var_348_16 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_21 + var_348_16
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_22 = var_348_16 + 0.3
			local var_348_23 = math.max(var_348_17, arg_345_1.talkMaxDuration)

			if var_348_16 + 0.3 <= arg_345_1.time_ and arg_345_1.time_ < var_348_22 + var_348_23 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_22) / var_348_23

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_22 + var_348_23 and arg_345_1.time_ < var_348_22 + var_348_23 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play103304087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 103304087
		arg_351_1.duration_ = 4.2

		local var_351_0 = {
			ja = 4.2,
			ko = 3.733,
			zh = 3.766,
			en = 3.933
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play103304088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.425

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_1 = arg_351_1:GetWordFromCfg(103304087)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 17 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 17)

				if (17 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 17)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304087", "story_v_side_old_103304.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304087", "story_v_side_old_103304.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_side_old_103304", "103304087", "story_v_side_old_103304.awb")

						arg_351_1:RecordAudio("103304087", var_354_6)
						arg_351_1:RecordAudio("103304087", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304087", "story_v_side_old_103304.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304087", "story_v_side_old_103304.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play103304088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 103304088
		arg_355_1.duration_ = 7.9

		local var_355_0 = {
			ja = 7.9,
			ko = 2.966,
			zh = 3.6,
			en = 3.266
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play103304089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1033ui_story = arg_355_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1033ui_story"].transform.position).z)
				arg_355_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1033ui_story"].transform.localEulerAngles = arg_355_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_355_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1033ui_story"].transform.position).z)
				arg_355_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1033ui_story"].transform.localEulerAngles = arg_355_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_358_1 = arg_355_1.actors_["1033ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1033ui_story == nil then
				arg_355_1.var_.characterEffect1033ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect1033ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1033ui_story then
				arg_355_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_2")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_358_4 = 0
			local var_358_5 = 0.225

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(103304088)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 9 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 9)

				if (9 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 9)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304088", "story_v_side_old_103304.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304088", "story_v_side_old_103304.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_side_old_103304", "103304088", "story_v_side_old_103304.awb")

						arg_355_1:RecordAudio("103304088", var_358_11)
						arg_355_1:RecordAudio("103304088", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304088", "story_v_side_old_103304.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304088", "story_v_side_old_103304.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play103304089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 103304089
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play103304090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1033ui_story = arg_359_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1033ui_story"].transform.position).z)
				arg_359_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1033ui_story"].transform.localEulerAngles = arg_359_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1033ui_story"].transform.position).z)
				arg_359_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1033ui_story"].transform.localEulerAngles = arg_359_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_alert", "")
			end

			local var_362_2 = 0
			local var_362_3 = 0.425

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_4 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(103304089).content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_6 = 17 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_4) / 17)

				if (17 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_4) / 17)) > 0 and var_362_3 < var_362_6 then
					arg_359_1.talkMaxDuration = var_362_6

					if var_362_6 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_6 + var_362_2
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_3, arg_359_1.talkMaxDuration)

			if var_362_2 <= arg_359_1.time_ and arg_359_1.time_ < var_362_2 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_2) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_2 + var_362_7 and arg_359_1.time_ < var_362_2 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play103304090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 103304090
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play103304091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.725

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(103304090).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 29 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 29)

				if (29 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 29)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play103304091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 103304091
		arg_367_1.duration_ = 9

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play103304092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if arg_367_1.bgs_.STblack == nil then
				local var_370_0 = Object.Instantiate(arg_367_1.paintGo_)

				var_370_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_370_0.name = "STblack"
				var_370_0.transform.parent = arg_367_1.stage_.transform
				var_370_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_367_1.bgs_.STblack = var_370_0
			end

			if 2 < arg_367_1.time_ and arg_367_1.time_ <= 2 + arg_370_0 then
				local var_370_1 = arg_367_1.bgs_.STblack

				arg_367_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_370_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_370_2 = var_370_1:GetComponent("SpriteRenderer")

				if var_370_2 and var_370_2.sprite then
					local var_370_3 = 2 * (var_370_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_370_1.transform.localScale = Vector3.New(var_370_3 / var_370_2.sprite.bounds.size.y < var_370_3 * manager.ui.mainCameraCom_.aspect / var_370_2.sprite.bounds.size.x and var_370_3 * manager.ui.mainCameraCom_.aspect / var_370_2.sprite.bounds.size.x or var_370_3 / var_370_2.sprite.bounds.size.y, var_370_3 / var_370_2.sprite.bounds.size.y < var_370_3 * manager.ui.mainCameraCom_.aspect / var_370_2.sprite.bounds.size.x and var_370_3 * manager.ui.mainCameraCom_.aspect / var_370_2.sprite.bounds.size.x or var_370_3 / var_370_2.sprite.bounds.size.y, 0)
				end

				for iter_370_0, iter_370_1 in pairs(arg_367_1.bgs_) do
					if iter_370_0 ~= "STblack" then
						iter_370_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_370_4 = 0

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.mask_.enabled = true
				arg_367_1.mask_.raycastTarget = true

				arg_367_1:SetGaussion(false)
			end

			local var_370_5 = 2

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_5 then
				local var_370_6 = Color.New(0.009433985, 0.004138493, 0.004138493)

				var_370_6.a = Mathf.Lerp(0, 1, (arg_367_1.time_ - var_370_4) / var_370_5)
				arg_367_1.mask_.color = var_370_6
			end

			if arg_367_1.time_ >= var_370_4 + var_370_5 and arg_367_1.time_ < var_370_4 + var_370_5 + arg_370_0 then
				local var_370_7 = Color.New(0.009433985, 0.004138493, 0.004138493)

				var_370_7.a = 1
				arg_367_1.mask_.color = var_370_7
			end

			local var_370_8 = 2

			if 2 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.mask_.enabled = true
				arg_367_1.mask_.raycastTarget = true

				arg_367_1:SetGaussion(false)
			end

			local var_370_9 = 2

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_9 then
				local var_370_10 = Color.New(0.009433985, 0.004138493, 0.004138493)

				var_370_10.a = Mathf.Lerp(1, 0, (arg_367_1.time_ - var_370_8) / var_370_9)
				arg_367_1.mask_.color = var_370_10
			end

			if arg_367_1.time_ >= var_370_8 + var_370_9 and arg_367_1.time_ < var_370_8 + var_370_9 + arg_370_0 then
				local var_370_11 = Color.New(0.009433985, 0.004138493, 0.004138493)

				arg_367_1.mask_.enabled = false
				var_370_11.a = 0
				arg_367_1.mask_.color = var_370_11
			end

			local var_370_12 = 0
			local var_370_13 = 0x0.0000000000001p-1022

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_12 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_14 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(103304091).content)

				arg_367_1.text_.text = var_370_14

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_16 = 2 <= 0 and var_370_13 or var_370_13 * (utf8.len(var_370_14) / 2)

				if (2 <= 0 and var_370_13 or var_370_13 * (utf8.len(var_370_14) / 2)) > 0 and var_370_13 < var_370_16 then
					arg_367_1.talkMaxDuration = var_370_16

					if var_370_16 + var_370_12 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_16 + var_370_12
					end
				end

				arg_367_1.text_.text = var_370_14
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_17 = math.max(var_370_13, arg_367_1.talkMaxDuration)

			if var_370_12 <= arg_367_1.time_ and arg_367_1.time_ < var_370_12 + var_370_17 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_12) / var_370_17

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_12 + var_370_17 and arg_367_1.time_ < var_370_12 + var_370_17 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end

			if arg_367_1.frameCnt_ <= 1 then
				arg_367_1.dialog_:SetActive(false)
			end

			local var_370_18 = 4
			local var_370_19 = 1

			if 4 < arg_367_1.time_ and arg_367_1.time_ <= var_370_18 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0

				arg_367_1.dialog_:SetActive(true)

				arg_367_1.dialogCg_.alpha = 0

				local var_370_20 = LeanTween.value(arg_367_1.dialog_, 0, 1, 0.3)

				var_370_20:setOnUpdate(LuaHelper.FloatAction(function(arg_371_0)
					arg_367_1.dialogCg_.alpha = arg_371_0
				end))
				var_370_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_367_1.dialog_)
					var_370_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_367_1.duration_ = arg_367_1.duration_ + 0.3

				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_21 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(103304091).content)

				arg_367_1.text_.text = var_370_21

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_23 = 2 <= 0 and var_370_19 or var_370_19 * (utf8.len(var_370_21) / 2)

				if (2 <= 0 and var_370_19 or var_370_19 * (utf8.len(var_370_21) / 2)) > 0 and var_370_19 < var_370_23 then
					arg_367_1.talkMaxDuration = var_370_23
					var_370_18 = var_370_18 + 0.3

					if var_370_23 + var_370_18 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_23 + var_370_18
					end
				end

				arg_367_1.text_.text = var_370_21
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_24 = var_370_18 + 0.3
			local var_370_25 = math.max(var_370_19, arg_367_1.talkMaxDuration)

			if var_370_18 + 0.3 <= arg_367_1.time_ and arg_367_1.time_ < var_370_24 + var_370_25 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_24) / var_370_25

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_24 + var_370_25 and arg_367_1.time_ < var_370_24 + var_370_25 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play103304092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 103304092
		arg_373_1.duration_ = 3.73

		local var_373_0 = {
			ja = 3.533333333332,
			ko = 3.533333333332,
			zh = 3.533333333332,
			en = 3.73333333333333
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play103304093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				local var_376_0 = arg_373_1.bgs_.B03e

				arg_373_1.bgs_.B03e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_376_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_376_1 = var_376_0:GetComponent("SpriteRenderer")

				if var_376_1 and var_376_1.sprite then
					local var_376_2 = 2 * (var_376_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_376_0.transform.localScale = Vector3.New(var_376_2 / var_376_1.sprite.bounds.size.y < var_376_2 * manager.ui.mainCameraCom_.aspect / var_376_1.sprite.bounds.size.x and var_376_2 * manager.ui.mainCameraCom_.aspect / var_376_1.sprite.bounds.size.x or var_376_2 / var_376_1.sprite.bounds.size.y, var_376_2 / var_376_1.sprite.bounds.size.y < var_376_2 * manager.ui.mainCameraCom_.aspect / var_376_1.sprite.bounds.size.x and var_376_2 * manager.ui.mainCameraCom_.aspect / var_376_1.sprite.bounds.size.x or var_376_2 / var_376_1.sprite.bounds.size.y, 0)
				end

				for iter_376_0, iter_376_1 in pairs(arg_373_1.bgs_) do
					if iter_376_0 ~= "B03e" then
						iter_376_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_376_3 = 0

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = false

				arg_373_1:SetGaussion(false)
			end

			local var_376_4 = 1.53333333333333

			if var_376_3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_3 + var_376_4 then
				local var_376_5 = Color.New(0.0754717, 0.03595586, 0.03595586)

				var_376_5.a = Mathf.Lerp(1, 0, (arg_373_1.time_ - var_376_3) / var_376_4)
				arg_373_1.mask_.color = var_376_5
			end

			if arg_373_1.time_ >= var_376_3 + var_376_4 and arg_373_1.time_ < var_376_3 + var_376_4 + arg_376_0 then
				local var_376_6 = Color.New(0.0754717, 0.03595586, 0.03595586)

				arg_373_1.mask_.enabled = false
				var_376_6.a = 0
				arg_373_1.mask_.color = var_376_6
			end

			local var_376_7 = arg_373_1.actors_["1033ui_story"].transform

			if 1.53333333333333 < arg_373_1.time_ and arg_373_1.time_ <= 1.53333333333333 + arg_376_0 then
				arg_373_1.var_.moveOldPos1033ui_story = var_376_7.localPosition
			end

			local var_376_8 = 0.001

			if 1.53333333333333 <= arg_373_1.time_ and arg_373_1.time_ < 1.53333333333333 + var_376_8 then
				var_376_7.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_373_1.time_ - 1.53333333333333) / var_376_8)
				var_376_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_7.position).x, (manager.ui.mainCamera.transform.position - var_376_7.position).y, (manager.ui.mainCamera.transform.position - var_376_7.position).z)
				var_376_7.localEulerAngles.z = 0
				var_376_7.localEulerAngles.x = 0
				var_376_7.localEulerAngles = var_376_7.localEulerAngles
			end

			if arg_373_1.time_ >= 1.53333333333333 + var_376_8 and arg_373_1.time_ < 1.53333333333333 + var_376_8 + arg_376_0 then
				var_376_7.localPosition = Vector3.New(0, -1.01, -6.13)
				var_376_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_7.position).x, (manager.ui.mainCamera.transform.position - var_376_7.position).y, (manager.ui.mainCamera.transform.position - var_376_7.position).z)
				var_376_7.localEulerAngles.z = 0
				var_376_7.localEulerAngles.x = 0
				var_376_7.localEulerAngles = var_376_7.localEulerAngles
			end

			local var_376_9 = arg_373_1.actors_["1033ui_story"]

			if 1.53333333333333 < arg_373_1.time_ and arg_373_1.time_ <= 1.53333333333333 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect1033ui_story == nil then
				arg_373_1.var_.characterEffect1033ui_story = var_376_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_10 = 0.2

			if 1.53333333333333 <= arg_373_1.time_ and arg_373_1.time_ < 1.53333333333333 + var_376_10 and not isNil(var_376_9) then
				if arg_373_1.var_.characterEffect1033ui_story and not isNil(var_376_9) then
					arg_373_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 1.53333333333333 + var_376_10 and arg_373_1.time_ < 1.53333333333333 + var_376_10 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect1033ui_story then
				arg_373_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 1.53333333333333 < arg_373_1.time_ and arg_373_1.time_ <= 1.53333333333333 + arg_376_0 then
				arg_373_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 1.53333333333333 < arg_373_1.time_ and arg_373_1.time_ <= 1.53333333333333 + arg_376_0 then
				arg_373_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if arg_373_1.frameCnt_ <= 1 then
				arg_373_1.dialog_:SetActive(false)
			end

			local var_376_12 = 1.53333333333333
			local var_376_13 = 0.05

			if 1.53333333333333 < arg_373_1.time_ and arg_373_1.time_ <= var_376_12 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				arg_373_1.dialog_:SetActive(true)

				arg_373_1.dialogCg_.alpha = 0

				local var_376_14 = LeanTween.value(arg_373_1.dialog_, 0, 1, 0.3)

				var_376_14:setOnUpdate(LuaHelper.FloatAction(function(arg_377_0)
					arg_373_1.dialogCg_.alpha = arg_377_0
				end))
				var_376_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_373_1.dialog_)
					var_376_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_373_1.duration_ = arg_373_1.duration_ + 0.3

				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_15 = arg_373_1:GetWordFromCfg(103304092)
				local var_376_16 = arg_373_1:FormatText(var_376_15.content)

				arg_373_1.text_.text = var_376_16

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_18 = 2 <= 0 and var_376_13 or var_376_13 * (utf8.len(var_376_16) / 2)

				if (2 <= 0 and var_376_13 or var_376_13 * (utf8.len(var_376_16) / 2)) > 0 and var_376_13 < var_376_18 then
					arg_373_1.talkMaxDuration = var_376_18
					var_376_12 = var_376_12 + 0.3

					if var_376_18 + var_376_12 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_18 + var_376_12
					end
				end

				arg_373_1.text_.text = var_376_16
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304092", "story_v_side_old_103304.awb") ~= 0 then
					local var_376_19 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304092", "story_v_side_old_103304.awb") / 1000

					if var_376_19 + var_376_12 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_19 + var_376_12
					end

					if var_376_15.prefab_name ~= "" and arg_373_1.actors_[var_376_15.prefab_name] ~= nil then
						local var_376_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_15.prefab_name].transform, "story_v_side_old_103304", "103304092", "story_v_side_old_103304.awb")

						arg_373_1:RecordAudio("103304092", var_376_20)
						arg_373_1:RecordAudio("103304092", var_376_20)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304092", "story_v_side_old_103304.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304092", "story_v_side_old_103304.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_21 = var_376_12 + 0.3
			local var_376_22 = math.max(var_376_13, arg_373_1.talkMaxDuration)

			if var_376_12 + 0.3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_21 + var_376_22 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_21) / var_376_22

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_21 + var_376_22 and arg_373_1.time_ < var_376_21 + var_376_22 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play103304093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 103304093
		arg_379_1.duration_ = 2.83

		local var_379_0 = {
			ja = 2.833,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play103304094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_382_0 = 0
			local var_382_1 = 0.1

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_2 = arg_379_1:GetWordFromCfg(103304093)
				local var_382_3 = arg_379_1:FormatText(var_382_2.content)

				arg_379_1.text_.text = var_382_3

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 4 <= 0 and var_382_1 or var_382_1 * (utf8.len(var_382_3) / 4)

				if (4 <= 0 and var_382_1 or var_382_1 * (utf8.len(var_382_3) / 4)) > 0 and var_382_1 < var_382_5 then
					arg_379_1.talkMaxDuration = var_382_5

					if var_382_5 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_3
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304093", "story_v_side_old_103304.awb") ~= 0 then
					local var_382_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304093", "story_v_side_old_103304.awb") / 1000

					if var_382_6 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_6 + var_382_0
					end

					if var_382_2.prefab_name ~= "" and arg_379_1.actors_[var_382_2.prefab_name] ~= nil then
						local var_382_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_2.prefab_name].transform, "story_v_side_old_103304", "103304093", "story_v_side_old_103304.awb")

						arg_379_1:RecordAudio("103304093", var_382_7)
						arg_379_1:RecordAudio("103304093", var_382_7)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304093", "story_v_side_old_103304.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304093", "story_v_side_old_103304.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_8 and arg_379_1.time_ < var_382_0 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play103304094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 103304094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play103304095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1033ui_story = arg_383_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1033ui_story"].transform.position).z)
				arg_383_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1033ui_story"].transform.localEulerAngles = arg_383_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1033ui_story"].transform.position).z)
				arg_383_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1033ui_story"].transform.localEulerAngles = arg_383_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_386_1 = 0
			local var_386_2 = 1.1

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(103304094).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 44 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 44)

				if (44 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 44)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play103304095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 103304095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play103304096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.5

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(103304095).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 20 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 20)

				if (20 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 20)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play103304096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 103304096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play103304097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.7

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(103304096).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 28 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 28)

				if (28 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 28)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play103304097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 103304097
		arg_395_1.duration_ = 5.33

		local var_395_0 = {
			ja = 5.333,
			ko = 2.366,
			zh = 2.666,
			en = 2.3
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play103304098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1033ui_story = arg_395_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1033ui_story"].transform.position).z)
				arg_395_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1033ui_story"].transform.localEulerAngles = arg_395_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_395_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1033ui_story"].transform.position).z)
				arg_395_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1033ui_story"].transform.localEulerAngles = arg_395_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1033ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1033ui_story == nil then
				arg_395_1.var_.characterEffect1033ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect1033ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1033ui_story then
				arg_395_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_398_4 = 0
			local var_398_5 = 0.175

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_6 = arg_395_1:GetWordFromCfg(103304097)
				local var_398_7 = arg_395_1:FormatText(var_398_6.content)

				arg_395_1.text_.text = var_398_7

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 7 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 7)

				if (7 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 7)) > 0 and var_398_5 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_7
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304097", "story_v_side_old_103304.awb") ~= 0 then
					local var_398_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304097", "story_v_side_old_103304.awb") / 1000

					if var_398_10 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_4
					end

					if var_398_6.prefab_name ~= "" and arg_395_1.actors_[var_398_6.prefab_name] ~= nil then
						local var_398_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_6.prefab_name].transform, "story_v_side_old_103304", "103304097", "story_v_side_old_103304.awb")

						arg_395_1:RecordAudio("103304097", var_398_11)
						arg_395_1:RecordAudio("103304097", var_398_11)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304097", "story_v_side_old_103304.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304097", "story_v_side_old_103304.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_12 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_12 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_12

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_12 and arg_395_1.time_ < var_398_4 + var_398_12 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play103304098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 103304098
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play103304099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1033ui_story"]) and arg_399_1.var_.characterEffect1033ui_story == nil then
				arg_399_1.var_.characterEffect1033ui_story = arg_399_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.216666666666667

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1033ui_story"]) then
				if arg_399_1.var_.characterEffect1033ui_story and not isNil(arg_399_1.actors_["1033ui_story"]) then
					arg_399_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1033ui_story"]) and arg_399_1.var_.characterEffect1033ui_story then
				arg_399_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.45

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(103304098).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 18 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 18)

				if (18 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 18)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play103304099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 103304099
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play103304100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.725

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(103304099).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 29 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 29)

				if (29 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 29)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play103304100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 103304100
		arg_407_1.duration_ = 13.53

		local var_407_0 = {
			ja = 13.533,
			ko = 5.866,
			zh = 4.966,
			en = 6.1
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play103304101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1033ui_story"]) and arg_407_1.var_.characterEffect1033ui_story == nil then
				arg_407_1.var_.characterEffect1033ui_story = arg_407_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1033ui_story"]) then
				if arg_407_1.var_.characterEffect1033ui_story and not isNil(arg_407_1.actors_["1033ui_story"]) then
					arg_407_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1033ui_story"]) and arg_407_1.var_.characterEffect1033ui_story then
				arg_407_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_410_2 = 0
			local var_410_3 = 0.5

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_4 = arg_407_1:GetWordFromCfg(103304100)
				local var_410_5 = arg_407_1:FormatText(var_410_4.content)

				arg_407_1.text_.text = var_410_5

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 20 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 20)

				if (20 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 20)) > 0 and var_410_3 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_2
					end
				end

				arg_407_1.text_.text = var_410_5
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304100", "story_v_side_old_103304.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304100", "story_v_side_old_103304.awb") / 1000

					if var_410_8 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_2
					end

					if var_410_4.prefab_name ~= "" and arg_407_1.actors_[var_410_4.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_4.prefab_name].transform, "story_v_side_old_103304", "103304100", "story_v_side_old_103304.awb")

						arg_407_1:RecordAudio("103304100", var_410_9)
						arg_407_1:RecordAudio("103304100", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304100", "story_v_side_old_103304.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304100", "story_v_side_old_103304.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_3, arg_407_1.talkMaxDuration)

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_2) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_2 + var_410_10 and arg_407_1.time_ < var_410_2 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play103304101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 103304101
		arg_411_1.duration_ = 10.87

		local var_411_0 = {
			ja = 6.766,
			ko = 9.233,
			zh = 10.866,
			en = 9.566
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play103304102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_414_0 = 0
			local var_414_1 = 0.85

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_2 = arg_411_1:GetWordFromCfg(103304101)
				local var_414_3 = arg_411_1:FormatText(var_414_2.content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 34 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 34)

				if (34 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 34)) > 0 and var_414_1 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304101", "story_v_side_old_103304.awb") ~= 0 then
					local var_414_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304101", "story_v_side_old_103304.awb") / 1000

					if var_414_6 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_0
					end

					if var_414_2.prefab_name ~= "" and arg_411_1.actors_[var_414_2.prefab_name] ~= nil then
						local var_414_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_2.prefab_name].transform, "story_v_side_old_103304", "103304101", "story_v_side_old_103304.awb")

						arg_411_1:RecordAudio("103304101", var_414_7)
						arg_411_1:RecordAudio("103304101", var_414_7)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304101", "story_v_side_old_103304.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304101", "story_v_side_old_103304.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_8 and arg_411_1.time_ < var_414_0 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play103304102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 103304102
		arg_415_1.duration_ = 10.53

		local var_415_0 = {
			ja = 10.533,
			ko = 7.366,
			zh = 5.6,
			en = 7.366
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play103304103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_418_0 = 0
			local var_418_1 = 0.55

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_2 = arg_415_1:GetWordFromCfg(103304102)
				local var_418_3 = arg_415_1:FormatText(var_418_2.content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 22 <= 0 and var_418_1 or var_418_1 * (utf8.len(var_418_3) / 22)

				if (22 <= 0 and var_418_1 or var_418_1 * (utf8.len(var_418_3) / 22)) > 0 and var_418_1 < var_418_5 then
					arg_415_1.talkMaxDuration = var_418_5

					if var_418_5 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304102", "story_v_side_old_103304.awb") ~= 0 then
					local var_418_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304102", "story_v_side_old_103304.awb") / 1000

					if var_418_6 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_6 + var_418_0
					end

					if var_418_2.prefab_name ~= "" and arg_415_1.actors_[var_418_2.prefab_name] ~= nil then
						local var_418_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_2.prefab_name].transform, "story_v_side_old_103304", "103304102", "story_v_side_old_103304.awb")

						arg_415_1:RecordAudio("103304102", var_418_7)
						arg_415_1:RecordAudio("103304102", var_418_7)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304102", "story_v_side_old_103304.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304102", "story_v_side_old_103304.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_8 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_8 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_8

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_8 and arg_415_1.time_ < var_418_0 + var_418_8 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play103304103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 103304103
		arg_419_1.duration_ = 4.9

		local var_419_0 = {
			ja = 4.9,
			ko = 3.733,
			zh = 4.766,
			en = 3.933
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play103304104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_422_0 = 0
			local var_422_1 = 0.35

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_2 = arg_419_1:GetWordFromCfg(103304103)
				local var_422_3 = arg_419_1:FormatText(var_422_2.content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 14 <= 0 and var_422_1 or var_422_1 * (utf8.len(var_422_3) / 14)

				if (14 <= 0 and var_422_1 or var_422_1 * (utf8.len(var_422_3) / 14)) > 0 and var_422_1 < var_422_5 then
					arg_419_1.talkMaxDuration = var_422_5

					if var_422_5 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304103", "story_v_side_old_103304.awb") ~= 0 then
					local var_422_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304103", "story_v_side_old_103304.awb") / 1000

					if var_422_6 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_0
					end

					if var_422_2.prefab_name ~= "" and arg_419_1.actors_[var_422_2.prefab_name] ~= nil then
						local var_422_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_2.prefab_name].transform, "story_v_side_old_103304", "103304103", "story_v_side_old_103304.awb")

						arg_419_1:RecordAudio("103304103", var_422_7)
						arg_419_1:RecordAudio("103304103", var_422_7)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304103", "story_v_side_old_103304.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304103", "story_v_side_old_103304.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_8 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_8 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_8

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_8 and arg_419_1.time_ < var_422_0 + var_422_8 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play103304104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 103304104
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play103304105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1033ui_story"]) and arg_423_1.var_.characterEffect1033ui_story == nil then
				arg_423_1.var_.characterEffect1033ui_story = arg_423_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1033ui_story"]) then
				if arg_423_1.var_.characterEffect1033ui_story and not isNil(arg_423_1.actors_["1033ui_story"]) then
					arg_423_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1033ui_story"]) and arg_423_1.var_.characterEffect1033ui_story then
				arg_423_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_426_1 = 0
			local var_426_2 = 0.7

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(103304104).content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 28 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 28)

				if (28 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 28)) > 0 and var_426_2 < var_426_5 then
					arg_423_1.talkMaxDuration = var_426_5

					if var_426_5 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_6 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_6 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_6

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_6 and arg_423_1.time_ < var_426_1 + var_426_6 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play103304105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 103304105
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play103304106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1033ui_story = arg_427_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1033ui_story"].transform.position).z)
				arg_427_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1033ui_story"].transform.localEulerAngles = arg_427_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_427_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1033ui_story"].transform.position).z)
				arg_427_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1033ui_story"].transform.localEulerAngles = arg_427_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_430_1 = 0
			local var_430_2 = 0.95

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_3 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(103304105).content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 38 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 38)

				if (38 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 38)) > 0 and var_430_2 < var_430_5 then
					arg_427_1.talkMaxDuration = var_430_5

					if var_430_5 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + var_430_1
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_6 = math.max(var_430_2, arg_427_1.talkMaxDuration)

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_6 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_1) / var_430_6

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_1 + var_430_6 and arg_427_1.time_ < var_430_1 + var_430_6 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play103304106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 103304106
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play103304107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0.95

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(103304106).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 38 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 38)

				if (38 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 38)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play103304107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 103304107
		arg_435_1.duration_ = 4.93

		local var_435_0 = {
			ja = 4.933,
			ko = 3.4,
			zh = 2.3,
			en = 3.433
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play103304108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1033ui_story = arg_435_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_438_0 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 then
				arg_435_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_435_1.time_ - 0) / var_438_0)
				arg_435_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1033ui_story"].transform.position).z)
				arg_435_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1033ui_story"].transform.localEulerAngles = arg_435_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 then
				arg_435_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_435_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1033ui_story"].transform.position).z)
				arg_435_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1033ui_story"].transform.localEulerAngles = arg_435_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_438_1 = arg_435_1.actors_["1033ui_story"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1033ui_story == nil then
				arg_435_1.var_.characterEffect1033ui_story = var_438_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_2 and not isNil(var_438_1) then
				if arg_435_1.var_.characterEffect1033ui_story and not isNil(var_438_1) then
					arg_435_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_2 and arg_435_1.time_ < 0 + var_438_2 + arg_438_0 and not isNil(var_438_1) and arg_435_1.var_.characterEffect1033ui_story then
				arg_435_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_438_4 = 0
			local var_438_5 = 0.325

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_6 = arg_435_1:GetWordFromCfg(103304107)
				local var_438_7 = arg_435_1:FormatText(var_438_6.content)

				arg_435_1.text_.text = var_438_7

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_9 = 13 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 13)

				if (13 <= 0 and var_438_5 or var_438_5 * (utf8.len(var_438_7) / 13)) > 0 and var_438_5 < var_438_9 then
					arg_435_1.talkMaxDuration = var_438_9

					if var_438_9 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_9 + var_438_4
					end
				end

				arg_435_1.text_.text = var_438_7
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304107", "story_v_side_old_103304.awb") ~= 0 then
					local var_438_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304107", "story_v_side_old_103304.awb") / 1000

					if var_438_10 + var_438_4 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_10 + var_438_4
					end

					if var_438_6.prefab_name ~= "" and arg_435_1.actors_[var_438_6.prefab_name] ~= nil then
						local var_438_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_6.prefab_name].transform, "story_v_side_old_103304", "103304107", "story_v_side_old_103304.awb")

						arg_435_1:RecordAudio("103304107", var_438_11)
						arg_435_1:RecordAudio("103304107", var_438_11)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304107", "story_v_side_old_103304.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304107", "story_v_side_old_103304.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_12 = math.max(var_438_5, arg_435_1.talkMaxDuration)

			if var_438_4 <= arg_435_1.time_ and arg_435_1.time_ < var_438_4 + var_438_12 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_4) / var_438_12

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_4 + var_438_12 and arg_435_1.time_ < var_438_4 + var_438_12 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play103304108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 103304108
		arg_439_1.duration_ = 7.2

		local var_439_0 = {
			ja = 7.2,
			ko = 3.666,
			zh = 5.9,
			en = 3.666
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play103304109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_442_0 = 0
			local var_442_1 = 0.325

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_2 = arg_439_1:GetWordFromCfg(103304108)
				local var_442_3 = arg_439_1:FormatText(var_442_2.content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 13 <= 0 and var_442_1 or var_442_1 * (utf8.len(var_442_3) / 13)

				if (13 <= 0 and var_442_1 or var_442_1 * (utf8.len(var_442_3) / 13)) > 0 and var_442_1 < var_442_5 then
					arg_439_1.talkMaxDuration = var_442_5

					if var_442_5 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304108", "story_v_side_old_103304.awb") ~= 0 then
					local var_442_6 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304108", "story_v_side_old_103304.awb") / 1000

					if var_442_6 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_0
					end

					if var_442_2.prefab_name ~= "" and arg_439_1.actors_[var_442_2.prefab_name] ~= nil then
						local var_442_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_2.prefab_name].transform, "story_v_side_old_103304", "103304108", "story_v_side_old_103304.awb")

						arg_439_1:RecordAudio("103304108", var_442_7)
						arg_439_1:RecordAudio("103304108", var_442_7)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304108", "story_v_side_old_103304.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304108", "story_v_side_old_103304.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_8 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_8 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_8

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_8 and arg_439_1.time_ < var_442_0 + var_442_8 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play103304109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 103304109
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play103304110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["1033ui_story"]) and arg_443_1.var_.characterEffect1033ui_story == nil then
				arg_443_1.var_.characterEffect1033ui_story = arg_443_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_0 = 0.2

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["1033ui_story"]) then
				if arg_443_1.var_.characterEffect1033ui_story and not isNil(arg_443_1.actors_["1033ui_story"]) then
					arg_443_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_443_1.time_ - 0) / var_446_0)
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["1033ui_story"]) and arg_443_1.var_.characterEffect1033ui_story then
				arg_443_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_446_1 = 0
			local var_446_2 = 0.525

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_3 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(103304109).content)

				arg_443_1.text_.text = var_446_3

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 21 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 21)

				if (21 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 21)) > 0 and var_446_2 < var_446_5 then
					arg_443_1.talkMaxDuration = var_446_5

					if var_446_5 + var_446_1 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + var_446_1
					end
				end

				arg_443_1.text_.text = var_446_3
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_6 = math.max(var_446_2, arg_443_1.talkMaxDuration)

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_6 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_1) / var_446_6

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_1 + var_446_6 and arg_443_1.time_ < var_446_1 + var_446_6 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play103304110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 103304110
		arg_447_1.duration_ = 4.5

		local var_447_0 = {
			ja = 3.1,
			ko = 2.266,
			zh = 4.5,
			en = 2.433
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play103304111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["1033ui_story"]) and arg_447_1.var_.characterEffect1033ui_story == nil then
				arg_447_1.var_.characterEffect1033ui_story = arg_447_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_0 = 0.2

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["1033ui_story"]) then
				if arg_447_1.var_.characterEffect1033ui_story and not isNil(arg_447_1.actors_["1033ui_story"]) then
					arg_447_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["1033ui_story"]) and arg_447_1.var_.characterEffect1033ui_story then
				arg_447_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_450_2 = 0

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_2 + arg_450_0 then
				arg_447_1.mask_.enabled = true
				arg_447_1.mask_.raycastTarget = false

				arg_447_1:SetGaussion(false)
			end

			local var_450_3 = 2

			if var_450_2 <= arg_447_1.time_ and arg_447_1.time_ < var_450_2 + var_450_3 then
				local var_450_4 = Color.New(0, 0, 0)

				var_450_4.a = Mathf.Lerp(0, 1, (arg_447_1.time_ - var_450_2) / var_450_3)
				arg_447_1.mask_.color = var_450_4
			end

			if arg_447_1.time_ >= var_450_2 + var_450_3 and arg_447_1.time_ < var_450_2 + var_450_3 + arg_450_0 then
				local var_450_5 = Color.New(0, 0, 0)

				var_450_5.a = 1
				arg_447_1.mask_.color = var_450_5
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:AudioAction("stop", "effect", "se_story_side_1033", "se_story_1033_alert", "")
			end

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_button", "")
			end

			local var_450_8 = 0
			local var_450_9 = 0.2

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_8 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_10 = arg_447_1:GetWordFromCfg(103304110)
				local var_450_11 = arg_447_1:FormatText(var_450_10.content)

				arg_447_1.text_.text = var_450_11

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_13 = 8 <= 0 and var_450_9 or var_450_9 * (utf8.len(var_450_11) / 8)

				if (8 <= 0 and var_450_9 or var_450_9 * (utf8.len(var_450_11) / 8)) > 0 and var_450_9 < var_450_13 then
					arg_447_1.talkMaxDuration = var_450_13

					if var_450_13 + var_450_8 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_13 + var_450_8
					end
				end

				arg_447_1.text_.text = var_450_11
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304110", "story_v_side_old_103304.awb") ~= 0 then
					local var_450_14 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304110", "story_v_side_old_103304.awb") / 1000

					if var_450_14 + var_450_8 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_14 + var_450_8
					end

					if var_450_10.prefab_name ~= "" and arg_447_1.actors_[var_450_10.prefab_name] ~= nil then
						local var_450_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_10.prefab_name].transform, "story_v_side_old_103304", "103304110", "story_v_side_old_103304.awb")

						arg_447_1:RecordAudio("103304110", var_450_15)
						arg_447_1:RecordAudio("103304110", var_450_15)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304110", "story_v_side_old_103304.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304110", "story_v_side_old_103304.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_16 = math.max(var_450_9, arg_447_1.talkMaxDuration)

			if var_450_8 <= arg_447_1.time_ and arg_447_1.time_ < var_450_8 + var_450_16 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_8) / var_450_16

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_8 + var_450_16 and arg_447_1.time_ < var_450_8 + var_450_16 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play103304111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 103304111
		arg_451_1.duration_ = 6

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play103304112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				local var_454_0 = arg_451_1.bgs_.ST18

				arg_451_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_454_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_454_1 = var_454_0:GetComponent("SpriteRenderer")

				if var_454_1 and var_454_1.sprite then
					local var_454_2 = 2 * (var_454_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_454_0.transform.localScale = Vector3.New(var_454_2 / var_454_1.sprite.bounds.size.y < var_454_2 * manager.ui.mainCameraCom_.aspect / var_454_1.sprite.bounds.size.x and var_454_2 * manager.ui.mainCameraCom_.aspect / var_454_1.sprite.bounds.size.x or var_454_2 / var_454_1.sprite.bounds.size.y, var_454_2 / var_454_1.sprite.bounds.size.y < var_454_2 * manager.ui.mainCameraCom_.aspect / var_454_1.sprite.bounds.size.x and var_454_2 * manager.ui.mainCameraCom_.aspect / var_454_1.sprite.bounds.size.x or var_454_2 / var_454_1.sprite.bounds.size.y, 0)
				end

				for iter_454_0, iter_454_1 in pairs(arg_451_1.bgs_) do
					if iter_454_0 ~= "ST18" then
						iter_454_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_454_3 = 0

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_3 + arg_454_0 then
				arg_451_1.mask_.enabled = true
				arg_451_1.mask_.raycastTarget = false

				arg_451_1:SetGaussion(false)
			end

			local var_454_4 = 1

			if var_454_3 <= arg_451_1.time_ and arg_451_1.time_ < var_454_3 + var_454_4 then
				local var_454_5 = Color.New(0, 0, 0)

				var_454_5.a = Mathf.Lerp(1, 0, (arg_451_1.time_ - var_454_3) / var_454_4)
				arg_451_1.mask_.color = var_454_5
			end

			if arg_451_1.time_ >= var_454_3 + var_454_4 and arg_451_1.time_ < var_454_3 + var_454_4 + arg_454_0 then
				local var_454_6 = Color.New(0, 0, 0)

				arg_451_1.mask_.enabled = false
				var_454_6.a = 0
				arg_451_1.mask_.color = var_454_6
			end

			local var_454_7 = arg_451_1.actors_["1033ui_story"].transform

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1033ui_story = var_454_7.localPosition
			end

			local var_454_8 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_8 then
				var_454_7.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_451_1.time_ - 0) / var_454_8)
				var_454_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_7.position).x, (manager.ui.mainCamera.transform.position - var_454_7.position).y, (manager.ui.mainCamera.transform.position - var_454_7.position).z)
				var_454_7.localEulerAngles.z = 0
				var_454_7.localEulerAngles.x = 0
				var_454_7.localEulerAngles = var_454_7.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_8 and arg_451_1.time_ < 0 + var_454_8 + arg_454_0 then
				var_454_7.localPosition = Vector3.New(0, 100, 0)
				var_454_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_454_7.position).x, (manager.ui.mainCamera.transform.position - var_454_7.position).y, (manager.ui.mainCamera.transform.position - var_454_7.position).z)
				var_454_7.localEulerAngles.z = 0
				var_454_7.localEulerAngles.x = 0
				var_454_7.localEulerAngles = var_454_7.localEulerAngles
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_454_11 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_451_1.bgmTxt_.text ~= var_454_11 and arg_451_1.bgmTxt_.text ~= "" then
						if arg_451_1.bgmTxt2_.text ~= "" then
							arg_451_1.bgmTxt_.text = arg_451_1.bgmTxt2_.text
						end

						arg_451_1.bgmTxt2_.text = var_454_11

						arg_451_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_451_1.bgmTxt_.text = var_454_11
						arg_451_1.bgmTxt2_.text = var_454_11
					end

					if arg_451_1.bgmTimer then
						arg_451_1.bgmTimer:Stop()

						arg_451_1.bgmTimer = nil
					end

					if arg_451_1.settingData.show_music_name == 1 then
						arg_451_1.musicController:SetSelectedState("show")
						arg_451_1.musicAnimator_:Play("open", 0, 0)

						if arg_451_1.settingData.music_time ~= 0 then
							arg_451_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_451_1.settingData.music_time), function()
								if arg_451_1 == nil or isNil(arg_451_1.bgmTxt_) then
									return
								end

								arg_451_1.musicController:SetSelectedState("hide")
								arg_451_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_451_1.frameCnt_ <= 1 then
				arg_451_1.dialog_:SetActive(false)
			end

			local var_454_12 = 1
			local var_454_13 = 0.175

			if 1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_12 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0

				arg_451_1.dialog_:SetActive(true)

				arg_451_1.dialogCg_.alpha = 0

				local var_454_14 = LeanTween.value(arg_451_1.dialog_, 0, 1, 0.3)

				var_454_14:setOnUpdate(LuaHelper.FloatAction(function(arg_456_0)
					arg_451_1.dialogCg_.alpha = arg_456_0
				end))
				var_454_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_451_1.dialog_)
					var_454_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_451_1.duration_ = arg_451_1.duration_ + 0.3

				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_15 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(103304111).content)

				arg_451_1.text_.text = var_454_15

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_17 = 7 <= 0 and var_454_13 or var_454_13 * (utf8.len(var_454_15) / 7)

				if (7 <= 0 and var_454_13 or var_454_13 * (utf8.len(var_454_15) / 7)) > 0 and var_454_13 < var_454_17 then
					arg_451_1.talkMaxDuration = var_454_17
					var_454_12 = var_454_12 + 0.3

					if var_454_17 + var_454_12 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_17 + var_454_12
					end
				end

				arg_451_1.text_.text = var_454_15
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_18 = var_454_12 + 0.3
			local var_454_19 = math.max(var_454_13, arg_451_1.talkMaxDuration)

			if var_454_12 + 0.3 <= arg_451_1.time_ and arg_451_1.time_ < var_454_18 + var_454_19 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_18) / var_454_19

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_18 + var_454_19 and arg_451_1.time_ < var_454_18 + var_454_19 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play103304112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 103304112
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play103304113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 1

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_1 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(103304112).content)

				arg_458_1.text_.text = var_461_1

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_3 = 40 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_1) / 40)

				if (40 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_1) / 40)) > 0 and var_461_0 < var_461_3 then
					arg_458_1.talkMaxDuration = var_461_3

					if var_461_3 + 0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_3 + 0
					end
				end

				arg_458_1.text_.text = var_461_1
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_4 = math.max(var_461_0, arg_458_1.talkMaxDuration)

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_4 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - 0) / var_461_4

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= 0 + var_461_4 and arg_458_1.time_ < 0 + var_461_4 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play103304113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 103304113
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play103304114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0.2

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_1 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(103304113).content)

				arg_462_1.text_.text = var_465_1

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_3 = 8 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 8)

				if (8 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 8)) > 0 and var_465_0 < var_465_3 then
					arg_462_1.talkMaxDuration = var_465_3

					if var_465_3 + 0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_3 + 0
					end
				end

				arg_462_1.text_.text = var_465_1
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_4 = math.max(var_465_0, arg_462_1.talkMaxDuration)

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - 0) / var_465_4

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play103304114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 103304114
		arg_466_1.duration_ = 8.4

		local var_466_0 = {
			ja = 8.4,
			ko = 7.733,
			zh = 6.5,
			en = 5.333
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play103304115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.var_.moveOldPos1033ui_story = arg_466_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_469_0 = 0.001

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 then
				arg_466_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_466_1.time_ - 0) / var_469_0)
				arg_466_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_466_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1033ui_story"].transform.position).z)
				arg_466_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_466_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_466_1.actors_["1033ui_story"].transform.localEulerAngles = arg_466_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 then
				arg_466_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_466_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_466_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_466_1.actors_["1033ui_story"].transform.position).z)
				arg_466_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_466_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_466_1.actors_["1033ui_story"].transform.localEulerAngles = arg_466_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_469_1 = arg_466_1.actors_["1033ui_story"]

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(var_469_1) and arg_466_1.var_.characterEffect1033ui_story == nil then
				arg_466_1.var_.characterEffect1033ui_story = var_469_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.2

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_2 and not isNil(var_469_1) then
				if arg_466_1.var_.characterEffect1033ui_story and not isNil(var_469_1) then
					arg_466_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= 0 + var_469_2 and arg_466_1.time_ < 0 + var_469_2 + arg_469_0 and not isNil(var_469_1) and arg_466_1.var_.characterEffect1033ui_story then
				arg_466_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_1")
			end

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_469_4 = 0
			local var_469_5 = 0.625

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_4 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_6 = arg_466_1:GetWordFromCfg(103304114)
				local var_469_7 = arg_466_1:FormatText(var_469_6.content)

				arg_466_1.text_.text = var_469_7

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_9 = 25 <= 0 and var_469_5 or var_469_5 * (utf8.len(var_469_7) / 25)

				if (25 <= 0 and var_469_5 or var_469_5 * (utf8.len(var_469_7) / 25)) > 0 and var_469_5 < var_469_9 then
					arg_466_1.talkMaxDuration = var_469_9

					if var_469_9 + var_469_4 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_9 + var_469_4
					end
				end

				arg_466_1.text_.text = var_469_7
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304114", "story_v_side_old_103304.awb") ~= 0 then
					local var_469_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304114", "story_v_side_old_103304.awb") / 1000

					if var_469_10 + var_469_4 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_10 + var_469_4
					end

					if var_469_6.prefab_name ~= "" and arg_466_1.actors_[var_469_6.prefab_name] ~= nil then
						local var_469_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_6.prefab_name].transform, "story_v_side_old_103304", "103304114", "story_v_side_old_103304.awb")

						arg_466_1:RecordAudio("103304114", var_469_11)
						arg_466_1:RecordAudio("103304114", var_469_11)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304114", "story_v_side_old_103304.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304114", "story_v_side_old_103304.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_12 = math.max(var_469_5, arg_466_1.talkMaxDuration)

			if var_469_4 <= arg_466_1.time_ and arg_466_1.time_ < var_469_4 + var_469_12 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_4) / var_469_12

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_4 + var_469_12 and arg_466_1.time_ < var_469_4 + var_469_12 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play103304115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 103304115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play103304116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1033ui_story = arg_470_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).z)
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles = arg_470_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_470_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1033ui_story"].transform.position).z)
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1033ui_story"].transform.localEulerAngles = arg_470_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_473_1 = 0
			local var_473_2 = 0.7

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_3 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(103304115).content)

				arg_470_1.text_.text = var_473_3

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_5 = 28 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_3) / 28)

				if (28 <= 0 and var_473_2 or var_473_2 * (utf8.len(var_473_3) / 28)) > 0 and var_473_2 < var_473_5 then
					arg_470_1.talkMaxDuration = var_473_5

					if var_473_5 + var_473_1 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + var_473_1
					end
				end

				arg_470_1.text_.text = var_473_3
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_6 = math.max(var_473_2, arg_470_1.talkMaxDuration)

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_6 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_1) / var_473_6

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_1 + var_473_6 and arg_470_1.time_ < var_473_1 + var_473_6 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play103304116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 103304116
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play103304117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0.575

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_1 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(103304116).content)

				arg_474_1.text_.text = var_477_1

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_3 = 23 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 23)

				if (23 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_1) / 23)) > 0 and var_477_0 < var_477_3 then
					arg_474_1.talkMaxDuration = var_477_3

					if var_477_3 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_3 + 0
					end
				end

				arg_474_1.text_.text = var_477_1
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_4 = math.max(var_477_0, arg_474_1.talkMaxDuration)

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_4 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - 0) / var_477_4

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= 0 + var_477_4 and arg_474_1.time_ < 0 + var_477_4 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play103304117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 103304117
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play103304118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0.925

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_1 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(103304117).content)

				arg_478_1.text_.text = var_481_1

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_3 = 37 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_1) / 37)

				if (37 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_1) / 37)) > 0 and var_481_0 < var_481_3 then
					arg_478_1.talkMaxDuration = var_481_3

					if var_481_3 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_3 + 0
					end
				end

				arg_478_1.text_.text = var_481_1
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_4 = math.max(var_481_0, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_4 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - 0) / var_481_4

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_4 and arg_478_1.time_ < 0 + var_481_4 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play103304118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 103304118
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play103304119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.175

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_1 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(103304118).content)

				arg_482_1.text_.text = var_485_1

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_3 = 7 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_1) / 7)

				if (7 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_1) / 7)) > 0 and var_485_0 < var_485_3 then
					arg_482_1.talkMaxDuration = var_485_3

					if var_485_3 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_3 + 0
					end
				end

				arg_482_1.text_.text = var_485_1
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_4 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_4 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_4

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_4 and arg_482_1.time_ < 0 + var_485_4 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play103304119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 103304119
		arg_486_1.duration_ = 2.9

		local var_486_0 = {
			ja = 2.9,
			ko = 2.233,
			zh = 1.9,
			en = 2.033
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play103304120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0.175

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_1 = arg_486_1:GetWordFromCfg(103304119)
				local var_489_2 = arg_486_1:FormatText(var_489_1.content)

				arg_486_1.text_.text = var_489_2

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_4 = 7 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 7)

				if (7 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 7)) > 0 and var_489_0 < var_489_4 then
					arg_486_1.talkMaxDuration = var_489_4

					if var_489_4 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_4 + 0
					end
				end

				arg_486_1.text_.text = var_489_2
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304119", "story_v_side_old_103304.awb") ~= 0 then
					local var_489_5 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304119", "story_v_side_old_103304.awb") / 1000

					if var_489_5 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_5 + 0
					end

					if var_489_1.prefab_name ~= "" and arg_486_1.actors_[var_489_1.prefab_name] ~= nil then
						local var_489_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_1.prefab_name].transform, "story_v_side_old_103304", "103304119", "story_v_side_old_103304.awb")

						arg_486_1:RecordAudio("103304119", var_489_6)
						arg_486_1:RecordAudio("103304119", var_489_6)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304119", "story_v_side_old_103304.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304119", "story_v_side_old_103304.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_7 and arg_486_1.time_ < 0 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play103304120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 103304120
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play103304121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 1.4

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, false)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_1 = arg_490_1:FormatText(arg_490_1:GetWordFromCfg(103304120).content)

				arg_490_1.text_.text = var_493_1

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_3 = 56 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_1) / 56)

				if (56 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_1) / 56)) > 0 and var_493_0 < var_493_3 then
					arg_490_1.talkMaxDuration = var_493_3

					if var_493_3 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_3 + 0
					end
				end

				arg_490_1.text_.text = var_493_1
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_4 = math.max(var_493_0, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_4 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - 0) / var_493_4

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_4 and arg_490_1.time_ < 0 + var_493_4 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play103304121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 103304121
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play103304122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.225

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_1 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(103304121).content)

				arg_494_1.text_.text = var_497_1

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_3 = 9 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 9)

				if (9 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_1) / 9)) > 0 and var_497_0 < var_497_3 then
					arg_494_1.talkMaxDuration = var_497_3

					if var_497_3 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_3 + 0
					end
				end

				arg_494_1.text_.text = var_497_1
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_4 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_4 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_4

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_4 and arg_494_1.time_ < 0 + var_497_4 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play103304122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 103304122
		arg_498_1.duration_ = 6

		local var_498_0 = {
			ja = 6,
			ko = 3.4,
			zh = 2.766,
			en = 2.866
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play103304123(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos1033ui_story = arg_498_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_501_0 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 then
				arg_498_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_498_1.time_ - 0) / var_501_0)
				arg_498_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).z)
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles = arg_498_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 then
				arg_498_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_498_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_498_1.actors_["1033ui_story"].transform.position).z)
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_498_1.actors_["1033ui_story"].transform.localEulerAngles = arg_498_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_501_1 = arg_498_1.actors_["1033ui_story"]

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(var_501_1) and arg_498_1.var_.characterEffect1033ui_story == nil then
				arg_498_1.var_.characterEffect1033ui_story = var_501_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.2

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_2 and not isNil(var_501_1) then
				if arg_498_1.var_.characterEffect1033ui_story and not isNil(var_501_1) then
					arg_498_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_2 and arg_498_1.time_ < 0 + var_501_2 + arg_501_0 and not isNil(var_501_1) and arg_498_1.var_.characterEffect1033ui_story then
				arg_498_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action482")
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_501_4 = 0
			local var_501_5 = 0.4

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_6 = arg_498_1:GetWordFromCfg(103304122)
				local var_501_7 = arg_498_1:FormatText(var_501_6.content)

				arg_498_1.text_.text = var_501_7

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_9 = 16 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 16)

				if (16 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 16)) > 0 and var_501_5 < var_501_9 then
					arg_498_1.talkMaxDuration = var_501_9

					if var_501_9 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_9 + var_501_4
					end
				end

				arg_498_1.text_.text = var_501_7
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304122", "story_v_side_old_103304.awb") ~= 0 then
					local var_501_10 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304122", "story_v_side_old_103304.awb") / 1000

					if var_501_10 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_10 + var_501_4
					end

					if var_501_6.prefab_name ~= "" and arg_498_1.actors_[var_501_6.prefab_name] ~= nil then
						local var_501_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_6.prefab_name].transform, "story_v_side_old_103304", "103304122", "story_v_side_old_103304.awb")

						arg_498_1:RecordAudio("103304122", var_501_11)
						arg_498_1:RecordAudio("103304122", var_501_11)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304122", "story_v_side_old_103304.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304122", "story_v_side_old_103304.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_12 = math.max(var_501_5, arg_498_1.talkMaxDuration)

			if var_501_4 <= arg_498_1.time_ and arg_498_1.time_ < var_501_4 + var_501_12 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_4) / var_501_12

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_4 + var_501_12 and arg_498_1.time_ < var_501_4 + var_501_12 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_498_1:InitPlayNodeList()
	end,
	Play103304123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 103304123
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play103304124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(arg_502_1.actors_["1033ui_story"]) and arg_502_1.var_.characterEffect1033ui_story == nil then
				arg_502_1.var_.characterEffect1033ui_story = arg_502_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_0 = 0.2

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 and not isNil(arg_502_1.actors_["1033ui_story"]) then
				if arg_502_1.var_.characterEffect1033ui_story and not isNil(arg_502_1.actors_["1033ui_story"]) then
					arg_502_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_502_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_502_1.time_ - 0) / var_505_0)
				end
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 and not isNil(arg_502_1.actors_["1033ui_story"]) and arg_502_1.var_.characterEffect1033ui_story then
				arg_502_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_502_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_505_1 = 0
			local var_505_2 = 0.575

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_3 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(103304123).content)

				arg_502_1.text_.text = var_505_3

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 23 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_3) / 23)

				if (23 <= 0 and var_505_2 or var_505_2 * (utf8.len(var_505_3) / 23)) > 0 and var_505_2 < var_505_5 then
					arg_502_1.talkMaxDuration = var_505_5

					if var_505_5 + var_505_1 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_5 + var_505_1
					end
				end

				arg_502_1.text_.text = var_505_3
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_6 = math.max(var_505_2, arg_502_1.talkMaxDuration)

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_6 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_1) / var_505_6

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_1 + var_505_6 and arg_502_1.time_ < var_505_1 + var_505_6 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play103304124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 103304124
		arg_506_1.duration_ = 11.5

		local var_506_0 = {
			ja = 10.733,
			ko = 10.466,
			zh = 8.733,
			en = 11.5
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play103304125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(arg_506_1.actors_["1033ui_story"]) and arg_506_1.var_.characterEffect1033ui_story == nil then
				arg_506_1.var_.characterEffect1033ui_story = arg_506_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_0 = 0.2

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 and not isNil(arg_506_1.actors_["1033ui_story"]) then
				if arg_506_1.var_.characterEffect1033ui_story and not isNil(arg_506_1.actors_["1033ui_story"]) then
					arg_506_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 and not isNil(arg_506_1.actors_["1033ui_story"]) and arg_506_1.var_.characterEffect1033ui_story then
				arg_506_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_509_2 = 0
			local var_509_3 = 0.975

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_2 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_4 = arg_506_1:GetWordFromCfg(103304124)
				local var_509_5 = arg_506_1:FormatText(var_509_4.content)

				arg_506_1.text_.text = var_509_5

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_7 = 39 <= 0 and var_509_3 or var_509_3 * (utf8.len(var_509_5) / 39)

				if (39 <= 0 and var_509_3 or var_509_3 * (utf8.len(var_509_5) / 39)) > 0 and var_509_3 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_2 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_2
					end
				end

				arg_506_1.text_.text = var_509_5
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304124", "story_v_side_old_103304.awb") ~= 0 then
					local var_509_8 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304124", "story_v_side_old_103304.awb") / 1000

					if var_509_8 + var_509_2 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_8 + var_509_2
					end

					if var_509_4.prefab_name ~= "" and arg_506_1.actors_[var_509_4.prefab_name] ~= nil then
						local var_509_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_4.prefab_name].transform, "story_v_side_old_103304", "103304124", "story_v_side_old_103304.awb")

						arg_506_1:RecordAudio("103304124", var_509_9)
						arg_506_1:RecordAudio("103304124", var_509_9)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304124", "story_v_side_old_103304.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304124", "story_v_side_old_103304.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_10 = math.max(var_509_3, arg_506_1.talkMaxDuration)

			if var_509_2 <= arg_506_1.time_ and arg_506_1.time_ < var_509_2 + var_509_10 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_2) / var_509_10

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_2 + var_509_10 and arg_506_1.time_ < var_509_2 + var_509_10 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play103304125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 103304125
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play103304126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.var_.moveOldPos1033ui_story = arg_510_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_513_0 = 0.001

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 then
				arg_510_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_510_1.time_ - 0) / var_513_0)
				arg_510_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).z)
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles = arg_510_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 then
				arg_510_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_510_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_510_1.actors_["1033ui_story"].transform.position).z)
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_510_1.actors_["1033ui_story"].transform.localEulerAngles = arg_510_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_513_1 = 0
			local var_513_2 = 0.6

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_3 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(103304125).content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_5 = 24 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 24)

				if (24 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 24)) > 0 and var_513_2 < var_513_5 then
					arg_510_1.talkMaxDuration = var_513_5

					if var_513_5 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_5 + var_513_1
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_6 = math.max(var_513_2, arg_510_1.talkMaxDuration)

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_6 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_1) / var_513_6

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_1 + var_513_6 and arg_510_1.time_ < var_513_1 + var_513_6 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play103304126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 103304126
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play103304127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0.425

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_1 = arg_514_1:FormatText(arg_514_1:GetWordFromCfg(103304126).content)

				arg_514_1.text_.text = var_517_1

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_3 = 17 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_1) / 17)

				if (17 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_1) / 17)) > 0 and var_517_0 < var_517_3 then
					arg_514_1.talkMaxDuration = var_517_3

					if var_517_3 + 0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_3 + 0
					end
				end

				arg_514_1.text_.text = var_517_1
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_4 = math.max(var_517_0, arg_514_1.talkMaxDuration)

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_4 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - 0) / var_517_4

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= 0 + var_517_4 and arg_514_1.time_ < 0 + var_517_4 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play103304127 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 103304127
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play103304128(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0.825

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_1 = arg_518_1:FormatText(arg_518_1:GetWordFromCfg(103304127).content)

				arg_518_1.text_.text = var_521_1

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_3 = 33 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_1) / 33)

				if (33 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_1) / 33)) > 0 and var_521_0 < var_521_3 then
					arg_518_1.talkMaxDuration = var_521_3

					if var_521_3 + 0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_3 + 0
					end
				end

				arg_518_1.text_.text = var_521_1
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_4 = math.max(var_521_0, arg_518_1.talkMaxDuration)

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_4 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - 0) / var_521_4

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= 0 + var_521_4 and arg_518_1.time_ < 0 + var_521_4 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play103304128 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 103304128
		arg_522_1.duration_ = 9

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play103304129(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if arg_522_1.bgs_.R3301 == nil then
				local var_525_0 = Object.Instantiate(arg_522_1.paintGo_)

				var_525_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R3301")
				var_525_0.name = "R3301"
				var_525_0.transform.parent = arg_522_1.stage_.transform
				var_525_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_522_1.bgs_.R3301 = var_525_0
			end

			if 2 < arg_522_1.time_ and arg_522_1.time_ <= 2 + arg_525_0 then
				local var_525_1 = arg_522_1.bgs_.R3301

				arg_522_1.bgs_.R3301.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_525_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_525_2 = var_525_1:GetComponent("SpriteRenderer")

				if var_525_2 and var_525_2.sprite then
					local var_525_3 = 2 * (var_525_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_525_1.transform.localScale = Vector3.New(var_525_3 / var_525_2.sprite.bounds.size.y < var_525_3 * manager.ui.mainCameraCom_.aspect / var_525_2.sprite.bounds.size.x and var_525_3 * manager.ui.mainCameraCom_.aspect / var_525_2.sprite.bounds.size.x or var_525_3 / var_525_2.sprite.bounds.size.y, var_525_3 / var_525_2.sprite.bounds.size.y < var_525_3 * manager.ui.mainCameraCom_.aspect / var_525_2.sprite.bounds.size.x and var_525_3 * manager.ui.mainCameraCom_.aspect / var_525_2.sprite.bounds.size.x or var_525_3 / var_525_2.sprite.bounds.size.y, 0)
				end

				for iter_525_0, iter_525_1 in pairs(arg_522_1.bgs_) do
					if iter_525_0 ~= "R3301" then
						iter_525_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_525_4 = 0

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_5 = 2

			if var_525_4 <= arg_522_1.time_ and arg_522_1.time_ < var_525_4 + var_525_5 then
				local var_525_6 = Color.New(0, 0, 0)

				var_525_6.a = Mathf.Lerp(0, 1, (arg_522_1.time_ - var_525_4) / var_525_5)
				arg_522_1.mask_.color = var_525_6
			end

			if arg_522_1.time_ >= var_525_4 + var_525_5 and arg_522_1.time_ < var_525_4 + var_525_5 + arg_525_0 then
				local var_525_7 = Color.New(0, 0, 0)

				var_525_7.a = 1
				arg_522_1.mask_.color = var_525_7
			end

			local var_525_8 = 2

			if 2 < arg_522_1.time_ and arg_522_1.time_ <= var_525_8 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_9 = 2

			if var_525_8 <= arg_522_1.time_ and arg_522_1.time_ < var_525_8 + var_525_9 then
				local var_525_10 = Color.New(0, 0, 0)

				var_525_10.a = Mathf.Lerp(1, 0, (arg_522_1.time_ - var_525_8) / var_525_9)
				arg_522_1.mask_.color = var_525_10
			end

			if arg_522_1.time_ >= var_525_8 + var_525_9 and arg_522_1.time_ < var_525_8 + var_525_9 + arg_525_0 then
				local var_525_11 = Color.New(0, 0, 0)

				arg_522_1.mask_.enabled = false
				var_525_11.a = 0
				arg_522_1.mask_.color = var_525_11
			end

			local var_525_12 = 2

			arg_522_1.isInRecall_ = false

			if var_525_12 < arg_522_1.time_ and arg_522_1.time_ <= var_525_12 + arg_525_0 then
				arg_522_1.screenFilterGo_:SetActive(true)

				arg_522_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_525_2, iter_525_3 in pairs(arg_522_1.actors_) do
					for iter_525_4, iter_525_5 in ipairs((iter_525_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_525_5.color = iter_525_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_525_13 = 0.0166666666666667

			if var_525_12 <= arg_522_1.time_ and arg_522_1.time_ < var_525_12 + var_525_13 then
				arg_522_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_522_1.time_ - var_525_12) / var_525_13)
			end

			if arg_522_1.time_ >= var_525_12 + var_525_13 and arg_522_1.time_ < var_525_12 + var_525_13 + arg_525_0 then
				arg_522_1.screenFilterEffect_.weight = 1
			end

			if arg_522_1.frameCnt_ <= 1 then
				arg_522_1.dialog_:SetActive(false)
			end

			local var_525_14 = 4
			local var_525_15 = 0.975

			if 4 < arg_522_1.time_ and arg_522_1.time_ <= var_525_14 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0

				arg_522_1.dialog_:SetActive(true)

				arg_522_1.dialogCg_.alpha = 0

				local var_525_16 = LeanTween.value(arg_522_1.dialog_, 0, 1, 0.3)

				var_525_16:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_522_1.dialogCg_.alpha = arg_526_0
				end))
				var_525_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_522_1.dialog_)
					var_525_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_522_1.duration_ = arg_522_1.duration_ + 0.3

				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_17 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(103304128).content)

				arg_522_1.text_.text = var_525_17

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_19 = 39 <= 0 and var_525_15 or var_525_15 * (utf8.len(var_525_17) / 39)

				if (39 <= 0 and var_525_15 or var_525_15 * (utf8.len(var_525_17) / 39)) > 0 and var_525_15 < var_525_19 then
					arg_522_1.talkMaxDuration = var_525_19
					var_525_14 = var_525_14 + 0.3

					if var_525_19 + var_525_14 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_19 + var_525_14
					end
				end

				arg_522_1.text_.text = var_525_17
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_20 = var_525_14 + 0.3
			local var_525_21 = math.max(var_525_15, arg_522_1.talkMaxDuration)

			if var_525_14 + 0.3 <= arg_522_1.time_ and arg_522_1.time_ < var_525_20 + var_525_21 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_20) / var_525_21

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_20 + var_525_21 and arg_522_1.time_ < var_525_20 + var_525_21 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play103304129 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 103304129
		arg_528_1.duration_ = 6.17

		local var_528_0 = {
			ja = 6.166,
			ko = 5.066,
			zh = 4.666,
			en = 4.7
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play103304130(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				local var_531_0 = arg_528_1.bgs_.R3301

				arg_528_1.bgs_.R3301.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_531_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_531_1 = var_531_0:GetComponent("SpriteRenderer")

				if var_531_1 and var_531_1.sprite then
					local var_531_2 = 2 * (var_531_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_531_0.transform.localScale = Vector3.New(var_531_2 / var_531_1.sprite.bounds.size.y < var_531_2 * manager.ui.mainCameraCom_.aspect / var_531_1.sprite.bounds.size.x and var_531_2 * manager.ui.mainCameraCom_.aspect / var_531_1.sprite.bounds.size.x or var_531_2 / var_531_1.sprite.bounds.size.y, var_531_2 / var_531_1.sprite.bounds.size.y < var_531_2 * manager.ui.mainCameraCom_.aspect / var_531_1.sprite.bounds.size.x and var_531_2 * manager.ui.mainCameraCom_.aspect / var_531_1.sprite.bounds.size.x or var_531_2 / var_531_1.sprite.bounds.size.y, 0)
				end

				for iter_531_0, iter_531_1 in pairs(arg_528_1.bgs_) do
					if iter_531_0 ~= "R3301" then
						iter_531_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_528_1.time_ and arg_528_1.time_ <= 1 + arg_531_0 then
				local var_531_3 = arg_528_1.bgs_.ST18

				arg_528_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_531_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_531_4 = var_531_3:GetComponent("SpriteRenderer")

				if var_531_4 and var_531_4.sprite then
					local var_531_5 = 2 * (var_531_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_531_3.transform.localScale = Vector3.New(var_531_5 / var_531_4.sprite.bounds.size.y < var_531_5 * manager.ui.mainCameraCom_.aspect / var_531_4.sprite.bounds.size.x and var_531_5 * manager.ui.mainCameraCom_.aspect / var_531_4.sprite.bounds.size.x or var_531_5 / var_531_4.sprite.bounds.size.y, var_531_5 / var_531_4.sprite.bounds.size.y < var_531_5 * manager.ui.mainCameraCom_.aspect / var_531_4.sprite.bounds.size.x and var_531_5 * manager.ui.mainCameraCom_.aspect / var_531_4.sprite.bounds.size.x or var_531_5 / var_531_4.sprite.bounds.size.y, 0)
				end

				for iter_531_2, iter_531_3 in pairs(arg_528_1.bgs_) do
					if iter_531_2 ~= "ST18" then
						iter_531_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_531_6 = 0

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_6 + arg_531_0 then
				arg_528_1.mask_.enabled = true
				arg_528_1.mask_.raycastTarget = false

				arg_528_1:SetGaussion(false)
			end

			local var_531_7 = 1

			if var_531_6 <= arg_528_1.time_ and arg_528_1.time_ < var_531_6 + var_531_7 then
				local var_531_8 = Color.New(0, 0, 0)

				var_531_8.a = Mathf.Lerp(0, 1, (arg_528_1.time_ - var_531_6) / var_531_7)
				arg_528_1.mask_.color = var_531_8
			end

			if arg_528_1.time_ >= var_531_6 + var_531_7 and arg_528_1.time_ < var_531_6 + var_531_7 + arg_531_0 then
				local var_531_9 = Color.New(0, 0, 0)

				var_531_9.a = 1
				arg_528_1.mask_.color = var_531_9
			end

			local var_531_10 = 1

			if 1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_10 + arg_531_0 then
				arg_528_1.mask_.enabled = true
				arg_528_1.mask_.raycastTarget = false

				arg_528_1:SetGaussion(false)
			end

			local var_531_11 = 1

			if var_531_10 <= arg_528_1.time_ and arg_528_1.time_ < var_531_10 + var_531_11 then
				local var_531_12 = Color.New(0, 0, 0)

				var_531_12.a = Mathf.Lerp(1, 0, (arg_528_1.time_ - var_531_10) / var_531_11)
				arg_528_1.mask_.color = var_531_12
			end

			if arg_528_1.time_ >= var_531_10 + var_531_11 and arg_528_1.time_ < var_531_10 + var_531_11 + arg_531_0 then
				local var_531_13 = Color.New(0, 0, 0)

				arg_528_1.mask_.enabled = false
				var_531_13.a = 0
				arg_528_1.mask_.color = var_531_13
			end

			local var_531_14 = arg_528_1.actors_["1033ui_story"].transform

			if 2 < arg_528_1.time_ and arg_528_1.time_ <= 2 + arg_531_0 then
				arg_528_1.var_.moveOldPos1033ui_story = var_531_14.localPosition
			end

			local var_531_15 = 0.001

			if 2 <= arg_528_1.time_ and arg_528_1.time_ < 2 + var_531_15 then
				var_531_14.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_528_1.time_ - 2) / var_531_15)
				var_531_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_531_14.position).x, (manager.ui.mainCamera.transform.position - var_531_14.position).y, (manager.ui.mainCamera.transform.position - var_531_14.position).z)
				var_531_14.localEulerAngles.z = 0
				var_531_14.localEulerAngles.x = 0
				var_531_14.localEulerAngles = var_531_14.localEulerAngles
			end

			if arg_528_1.time_ >= 2 + var_531_15 and arg_528_1.time_ < 2 + var_531_15 + arg_531_0 then
				var_531_14.localPosition = Vector3.New(0, -1.01, -6.13)
				var_531_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_531_14.position).x, (manager.ui.mainCamera.transform.position - var_531_14.position).y, (manager.ui.mainCamera.transform.position - var_531_14.position).z)
				var_531_14.localEulerAngles.z = 0
				var_531_14.localEulerAngles.x = 0
				var_531_14.localEulerAngles = var_531_14.localEulerAngles
			end

			local var_531_16 = arg_528_1.actors_["1033ui_story"]

			if 2 < arg_528_1.time_ and arg_528_1.time_ <= 2 + arg_531_0 and not isNil(var_531_16) and arg_528_1.var_.characterEffect1033ui_story == nil then
				arg_528_1.var_.characterEffect1033ui_story = var_531_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_17 = 0.2

			if 2 <= arg_528_1.time_ and arg_528_1.time_ < 2 + var_531_17 and not isNil(var_531_16) then
				if arg_528_1.var_.characterEffect1033ui_story and not isNil(var_531_16) then
					arg_528_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= 2 + var_531_17 and arg_528_1.time_ < 2 + var_531_17 + arg_531_0 and not isNil(var_531_16) and arg_528_1.var_.characterEffect1033ui_story then
				arg_528_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 2 < arg_528_1.time_ and arg_528_1.time_ <= 2 + arg_531_0 then
				arg_528_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 2 < arg_528_1.time_ and arg_528_1.time_ <= 2 + arg_531_0 then
				arg_528_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_531_19 = 1

			arg_528_1.isInRecall_ = false

			if var_531_19 < arg_528_1.time_ and arg_528_1.time_ <= var_531_19 + arg_531_0 then
				arg_528_1.screenFilterGo_:SetActive(false)

				for iter_531_4, iter_531_5 in pairs(arg_528_1.actors_) do
					for iter_531_6, iter_531_7 in ipairs((iter_531_5:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_531_7.color = iter_531_7.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_531_20 = 0.0166666666666667

			if var_531_19 <= arg_528_1.time_ and arg_528_1.time_ < var_531_19 + var_531_20 then
				arg_528_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_528_1.time_ - var_531_19) / var_531_20)
			end

			if arg_528_1.time_ >= var_531_19 + var_531_20 and arg_528_1.time_ < var_531_19 + var_531_20 + arg_531_0 then
				arg_528_1.screenFilterEffect_.weight = 0
			end

			local var_531_21 = 2
			local var_531_22 = 0.325

			if 2 < arg_528_1.time_ and arg_528_1.time_ <= var_531_21 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_23 = arg_528_1:GetWordFromCfg(103304129)
				local var_531_24 = arg_528_1:FormatText(var_531_23.content)

				arg_528_1.text_.text = var_531_24

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_26 = 13 <= 0 and var_531_22 or var_531_22 * (utf8.len(var_531_24) / 13)

				if (13 <= 0 and var_531_22 or var_531_22 * (utf8.len(var_531_24) / 13)) > 0 and var_531_22 < var_531_26 then
					arg_528_1.talkMaxDuration = var_531_26

					if var_531_26 + var_531_21 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_26 + var_531_21
					end
				end

				arg_528_1.text_.text = var_531_24
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103304", "103304129", "story_v_side_old_103304.awb") ~= 0 then
					local var_531_27 = manager.audio:GetVoiceLength("story_v_side_old_103304", "103304129", "story_v_side_old_103304.awb") / 1000

					if var_531_27 + var_531_21 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_27 + var_531_21
					end

					if var_531_23.prefab_name ~= "" and arg_528_1.actors_[var_531_23.prefab_name] ~= nil then
						local var_531_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_23.prefab_name].transform, "story_v_side_old_103304", "103304129", "story_v_side_old_103304.awb")

						arg_528_1:RecordAudio("103304129", var_531_28)
						arg_528_1:RecordAudio("103304129", var_531_28)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_old_103304", "103304129", "story_v_side_old_103304.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_old_103304", "103304129", "story_v_side_old_103304.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_29 = math.max(var_531_22, arg_528_1.talkMaxDuration)

			if var_531_21 <= arg_528_1.time_ and arg_528_1.time_ < var_531_21 + var_531_29 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_21) / var_531_29

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_21 + var_531_29 and arg_528_1.time_ < var_531_21 + var_531_29 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_528_1:InitPlayNodeList()
	end,
	Play103304130 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 103304130
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play103304131(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 and not isNil(arg_532_1.actors_["1033ui_story"]) and arg_532_1.var_.characterEffect1033ui_story == nil then
				arg_532_1.var_.characterEffect1033ui_story = arg_532_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_535_0 = 0.2

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_0 and not isNil(arg_532_1.actors_["1033ui_story"]) then
				if arg_532_1.var_.characterEffect1033ui_story and not isNil(arg_532_1.actors_["1033ui_story"]) then
					arg_532_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_532_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_532_1.time_ - 0) / var_535_0)
				end
			end

			if arg_532_1.time_ >= 0 + var_535_0 and arg_532_1.time_ < 0 + var_535_0 + arg_535_0 and not isNil(arg_532_1.actors_["1033ui_story"]) and arg_532_1.var_.characterEffect1033ui_story then
				arg_532_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_532_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_535_1 = 0
			local var_535_2 = 0.05

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_3 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(103304130).content)

				arg_532_1.text_.text = var_535_3

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 2 <= 0 and var_535_2 or var_535_2 * (utf8.len(var_535_3) / 2)

				if (2 <= 0 and var_535_2 or var_535_2 * (utf8.len(var_535_3) / 2)) > 0 and var_535_2 < var_535_5 then
					arg_532_1.talkMaxDuration = var_535_5

					if var_535_5 + var_535_1 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_5 + var_535_1
					end
				end

				arg_532_1.text_.text = var_535_3
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_6 = math.max(var_535_2, arg_532_1.talkMaxDuration)

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_6 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_1) / var_535_6

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_1 + var_535_6 and arg_532_1.time_ < var_535_1 + var_535_6 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play103304131 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 103304131
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play103304132(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0.225

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_1 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(103304131).content)

				arg_536_1.text_.text = var_539_1

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_3 = 9 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_1) / 9)

				if (9 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_1) / 9)) > 0 and var_539_0 < var_539_3 then
					arg_536_1.talkMaxDuration = var_539_3

					if var_539_3 + 0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_3 + 0
					end
				end

				arg_536_1.text_.text = var_539_1
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_4 = math.max(var_539_0, arg_536_1.talkMaxDuration)

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_4 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - 0) / var_539_4

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= 0 + var_539_4 and arg_536_1.time_ < 0 + var_539_4 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play103304132 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 103304132
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play103304133(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action438")
			end

			local var_543_0 = 0
			local var_543_1 = 0.45

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_2 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(103304132).content)

				arg_540_1.text_.text = var_543_2

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_4 = 18 <= 0 and var_543_1 or var_543_1 * (utf8.len(var_543_2) / 18)

				if (18 <= 0 and var_543_1 or var_543_1 * (utf8.len(var_543_2) / 18)) > 0 and var_543_1 < var_543_4 then
					arg_540_1.talkMaxDuration = var_543_4

					if var_543_4 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_4 + var_543_0
					end
				end

				arg_540_1.text_.text = var_543_2
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_5 = math.max(var_543_1, arg_540_1.talkMaxDuration)

			if var_543_0 <= arg_540_1.time_ and arg_540_1.time_ < var_543_0 + var_543_5 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_0) / var_543_5

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_0 + var_543_5 and arg_540_1.time_ < var_543_0 + var_543_5 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play103304133 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 103304133
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
			arg_544_1.auto_ = false
		end

		function arg_544_1.playNext_(arg_546_0)
			arg_544_1.onStoryFinished_()
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos1033ui_story = arg_544_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_547_0 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_0 then
				arg_544_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_544_1.time_ - 0) / var_547_0)
				arg_544_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["1033ui_story"].transform.position).z)
				arg_544_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["1033ui_story"].transform.localEulerAngles = arg_544_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_544_1.time_ >= 0 + var_547_0 and arg_544_1.time_ < 0 + var_547_0 + arg_547_0 then
				arg_544_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_544_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["1033ui_story"].transform.position).z)
				arg_544_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["1033ui_story"].transform.localEulerAngles = arg_544_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_547_1 = 0
			local var_547_2 = 0.95

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_3 = arg_544_1:FormatText(arg_544_1:GetWordFromCfg(103304133).content)

				arg_544_1.text_.text = var_547_3

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_5 = 38 <= 0 and var_547_2 or var_547_2 * (utf8.len(var_547_3) / 38)

				if (38 <= 0 and var_547_2 or var_547_2 * (utf8.len(var_547_3) / 38)) > 0 and var_547_2 < var_547_5 then
					arg_544_1.talkMaxDuration = var_547_5

					if var_547_5 + var_547_1 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_5 + var_547_1
					end
				end

				arg_544_1.text_.text = var_547_3
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_6 = math.max(var_547_2, arg_544_1.talkMaxDuration)

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_6 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_1) / var_547_6

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_1 + var_547_6 and arg_544_1.time_ < var_547_1 + var_547_6 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/B03e",
		"TextureConfig/Background/B03d",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/R3301"
	},
	voices = {
		"story_v_side_old_103304.awb"
	}
}
