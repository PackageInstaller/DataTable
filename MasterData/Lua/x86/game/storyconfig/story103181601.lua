return {
	Play318161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318161001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A00 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_4_0.name = "A00"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A00 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A00

				arg_1_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A00" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0.8 < arg_1_1.time_ and arg_1_1.time_ <= 0.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.625

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(318161001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 25)

				if (25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 25)) > 0 and var_4_15 < var_4_19 then
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
	Play318161002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318161002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play318161003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_128", "se_story_128_knock", "")
			end

			local var_12_1 = 0
			local var_12_2 = 0.9

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(318161002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 36 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 36)

				if (36 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 36)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play318161003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318161003
		arg_13_1.duration_ = 1.23

		local var_13_0 = {
			zh = 0.999999999999,
			ja = 1.233
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play318161004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1019ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1019ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1019ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1019ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1019ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1019ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1019ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1019ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1019ui_story then
				arg_13_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.1

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(318161003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 4 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 4)

				if (4 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 4)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161003", "story_v_out_318161.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_318161", "318161003", "story_v_out_318161.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_318161", "318161003", "story_v_out_318161.awb")

						arg_13_1:RecordAudio("318161003", var_16_15)
						arg_13_1:RecordAudio("318161003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318161", "318161003", "story_v_out_318161.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318161", "318161003", "story_v_out_318161.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play318161004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318161004
		arg_17_1.duration_ = 4.4

		local var_17_0 = {
			zh = 4.133,
			ja = 4.4
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318161005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1028ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1028ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1028ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1028ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1028ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1028ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1028ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1028ui_story, Vector3.New(0.7, -0.9, -5.9), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0.7, -0.9, -5.9)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1028ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1028ui_story == nil then
				arg_17_1.var_.characterEffect1028ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1028ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1028ui_story then
				arg_17_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_20_8 = arg_17_1.actors_["1019ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1019ui_story = var_20_8.localPosition
			end

			local var_20_9 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_17_1.time_ - 0) / var_20_9)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			local var_20_10 = arg_17_1.actors_["1019ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1019ui_story then
				arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_20_12 = 0
			local var_20_13 = 0.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(318161004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 18 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 18)

				if (18 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 18)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161004", "story_v_out_318161.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_318161", "318161004", "story_v_out_318161.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_318161", "318161004", "story_v_out_318161.awb")

						arg_17_1:RecordAudio("318161004", var_20_19)
						arg_17_1:RecordAudio("318161004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_318161", "318161004", "story_v_out_318161.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_318161", "318161004", "story_v_out_318161.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play318161005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318161005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play318161006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1028ui_story"]) and arg_21_1.var_.characterEffect1028ui_story == nil then
				arg_21_1.var_.characterEffect1028ui_story = arg_21_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1028ui_story"]) then
				if arg_21_1.var_.characterEffect1028ui_story and not isNil(arg_21_1.actors_["1028ui_story"]) then
					arg_21_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1028ui_story"]) and arg_21_1.var_.characterEffect1028ui_story then
				arg_21_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(318161005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 40 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 40)

				if (40 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 40)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play318161006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318161006
		arg_25_1.duration_ = 10.77

		local var_25_0 = {
			zh = 10.1,
			ja = 10.766
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play318161007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1019ui_story"]) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = arg_25_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1019ui_story"]) then
				if arg_25_1.var_.characterEffect1019ui_story and not isNil(arg_25_1.actors_["1019ui_story"]) then
					arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1019ui_story"]) and arg_25_1.var_.characterEffect1019ui_story then
				arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_2 = arg_25_1.actors_["1019ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1019ui_story then
				arg_25_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_28_5 = 0
			local var_28_6 = 1.3

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(318161006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 52 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 52)

				if (52 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 52)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161006", "story_v_out_318161.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_318161", "318161006", "story_v_out_318161.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_318161", "318161006", "story_v_out_318161.awb")

						arg_25_1:RecordAudio("318161006", var_28_12)
						arg_25_1:RecordAudio("318161006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_318161", "318161006", "story_v_out_318161.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_318161", "318161006", "story_v_out_318161.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_13 and arg_25_1.time_ < var_28_5 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play318161007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318161007
		arg_29_1.duration_ = 7.63

		local var_29_0 = {
			zh = 7.3,
			ja = 7.633
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play318161008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1028ui_story"]) and arg_29_1.var_.characterEffect1028ui_story == nil then
				arg_29_1.var_.characterEffect1028ui_story = arg_29_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1028ui_story"]) then
				if arg_29_1.var_.characterEffect1028ui_story and not isNil(arg_29_1.actors_["1028ui_story"]) then
					arg_29_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1028ui_story"]) and arg_29_1.var_.characterEffect1028ui_story then
				arg_29_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_32_2 = arg_29_1.actors_["1019ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1019ui_story == nil then
				arg_29_1.var_.characterEffect1019ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect1019ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1019ui_story then
				arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_1")
			end

			local var_32_4 = 0
			local var_32_5 = 0.775

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(318161007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 31 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 31)

				if (31 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 31)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161007", "story_v_out_318161.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161007", "story_v_out_318161.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_318161", "318161007", "story_v_out_318161.awb")

						arg_29_1:RecordAudio("318161007", var_32_11)
						arg_29_1:RecordAudio("318161007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318161", "318161007", "story_v_out_318161.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318161", "318161007", "story_v_out_318161.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play318161008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318161008
		arg_33_1.duration_ = 12.67

		local var_33_0 = {
			zh = 12.666,
			ja = 8.733
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play318161009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_0 = 0
			local var_36_1 = 1.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(318161008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 60 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 60)

				if (60 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 60)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161008", "story_v_out_318161.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_out_318161", "318161008", "story_v_out_318161.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_out_318161", "318161008", "story_v_out_318161.awb")

						arg_33_1:RecordAudio("318161008", var_36_7)
						arg_33_1:RecordAudio("318161008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_318161", "318161008", "story_v_out_318161.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_318161", "318161008", "story_v_out_318161.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play318161009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318161009
		arg_37_1.duration_ = 7.63

		local var_37_0 = {
			zh = 5.7,
			ja = 7.633
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play318161010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028actionlink/1028action456")
			end

			local var_40_0 = 0
			local var_40_1 = 0.825

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(318161009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 33 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 33)

				if (33 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 33)) > 0 and var_40_1 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161009", "story_v_out_318161.awb") ~= 0 then
					local var_40_6 = manager.audio:GetVoiceLength("story_v_out_318161", "318161009", "story_v_out_318161.awb") / 1000

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end

					if var_40_2.prefab_name ~= "" and arg_37_1.actors_[var_40_2.prefab_name] ~= nil then
						local var_40_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_2.prefab_name].transform, "story_v_out_318161", "318161009", "story_v_out_318161.awb")

						arg_37_1:RecordAudio("318161009", var_40_7)
						arg_37_1:RecordAudio("318161009", var_40_7)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_318161", "318161009", "story_v_out_318161.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_318161", "318161009", "story_v_out_318161.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play318161010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318161010
		arg_41_1.duration_ = 8.67

		local var_41_0 = {
			zh = 4.633,
			ja = 8.666
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play318161011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) and arg_41_1.var_.characterEffect1019ui_story == nil then
				arg_41_1.var_.characterEffect1019ui_story = arg_41_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) then
				if arg_41_1.var_.characterEffect1019ui_story and not isNil(arg_41_1.actors_["1019ui_story"]) then
					arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) and arg_41_1.var_.characterEffect1019ui_story then
				arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["1028ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1028ui_story == nil then
				arg_41_1.var_.characterEffect1028ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1028ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1028ui_story then
				arg_41_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_44_4 = 0
			local var_44_5 = 0.675

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(318161010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 27 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 27)

				if (27 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 27)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161010", "story_v_out_318161.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161010", "story_v_out_318161.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_318161", "318161010", "story_v_out_318161.awb")

						arg_41_1:RecordAudio("318161010", var_44_11)
						arg_41_1:RecordAudio("318161010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_318161", "318161010", "story_v_out_318161.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_318161", "318161010", "story_v_out_318161.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play318161011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318161011
		arg_45_1.duration_ = 8.13

		local var_45_0 = {
			zh = 3.3,
			ja = 8.133
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play318161012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1028ui_story"]) and arg_45_1.var_.characterEffect1028ui_story == nil then
				arg_45_1.var_.characterEffect1028ui_story = arg_45_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1028ui_story"]) then
				if arg_45_1.var_.characterEffect1028ui_story and not isNil(arg_45_1.actors_["1028ui_story"]) then
					arg_45_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1028ui_story"]) and arg_45_1.var_.characterEffect1028ui_story then
				arg_45_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_2")
			end

			local var_48_2 = arg_45_1.actors_["1019ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1019ui_story == nil then
				arg_45_1.var_.characterEffect1019ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.characterEffect1019ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_3)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1019ui_story then
				arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_48_4 = 0
			local var_48_5 = 0.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(318161011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 19 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 19)

				if (19 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 19)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161011", "story_v_out_318161.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161011", "story_v_out_318161.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_318161", "318161011", "story_v_out_318161.awb")

						arg_45_1:RecordAudio("318161011", var_48_11)
						arg_45_1:RecordAudio("318161011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_318161", "318161011", "story_v_out_318161.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_318161", "318161011", "story_v_out_318161.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play318161012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318161012
		arg_49_1.duration_ = 7.03

		local var_49_0 = {
			zh = 7.033,
			ja = 5.533
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play318161013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1028ui_story"]) and arg_49_1.var_.characterEffect1028ui_story == nil then
				arg_49_1.var_.characterEffect1028ui_story = arg_49_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1028ui_story"]) then
				if arg_49_1.var_.characterEffect1028ui_story and not isNil(arg_49_1.actors_["1028ui_story"]) then
					arg_49_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1028ui_story"]) and arg_49_1.var_.characterEffect1028ui_story then
				arg_49_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_52_2 = 0
			local var_52_3 = 0.875

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(318161012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 35 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 35)

				if (35 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 35)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161012", "story_v_out_318161.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161012", "story_v_out_318161.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_318161", "318161012", "story_v_out_318161.awb")

						arg_49_1:RecordAudio("318161012", var_52_9)
						arg_49_1:RecordAudio("318161012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318161", "318161012", "story_v_out_318161.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318161", "318161012", "story_v_out_318161.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play318161013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318161013
		arg_53_1.duration_ = 10.57

		local var_53_0 = {
			zh = 9.866,
			ja = 10.566
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play318161014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1028ui_story"]) and arg_53_1.var_.characterEffect1028ui_story == nil then
				arg_53_1.var_.characterEffect1028ui_story = arg_53_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1028ui_story"]) then
				if arg_53_1.var_.characterEffect1028ui_story and not isNil(arg_53_1.actors_["1028ui_story"]) then
					arg_53_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1028ui_story"]) and arg_53_1.var_.characterEffect1028ui_story then
				arg_53_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_56_2 = 0
			local var_56_3 = 1.275

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(318161013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 51 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 51)

				if (51 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 51)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161013", "story_v_out_318161.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161013", "story_v_out_318161.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_318161", "318161013", "story_v_out_318161.awb")

						arg_53_1:RecordAudio("318161013", var_56_9)
						arg_53_1:RecordAudio("318161013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_318161", "318161013", "story_v_out_318161.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_318161", "318161013", "story_v_out_318161.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play318161014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318161014
		arg_57_1.duration_ = 11.1

		local var_57_0 = {
			zh = 4.6,
			ja = 11.1
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play318161015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1028ui_story"]) and arg_57_1.var_.characterEffect1028ui_story == nil then
				arg_57_1.var_.characterEffect1028ui_story = arg_57_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1028ui_story"]) then
				if arg_57_1.var_.characterEffect1028ui_story and not isNil(arg_57_1.actors_["1028ui_story"]) then
					arg_57_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1028ui_story"]) and arg_57_1.var_.characterEffect1028ui_story then
				arg_57_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_60_2 = 0
			local var_60_3 = 0.55

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(318161014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 22 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 22)

				if (22 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 22)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161014", "story_v_out_318161.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161014", "story_v_out_318161.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_318161", "318161014", "story_v_out_318161.awb")

						arg_57_1:RecordAudio("318161014", var_60_9)
						arg_57_1:RecordAudio("318161014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_318161", "318161014", "story_v_out_318161.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_318161", "318161014", "story_v_out_318161.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play318161015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 318161015
		arg_61_1.duration_ = 4.4

		local var_61_0 = {
			zh = 2.433,
			ja = 4.4
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play318161016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1019ui_story"]) and arg_61_1.var_.characterEffect1019ui_story == nil then
				arg_61_1.var_.characterEffect1019ui_story = arg_61_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1019ui_story"]) then
				if arg_61_1.var_.characterEffect1019ui_story and not isNil(arg_61_1.actors_["1019ui_story"]) then
					arg_61_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1019ui_story"]) and arg_61_1.var_.characterEffect1019ui_story then
				arg_61_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["1028ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1028ui_story == nil then
				arg_61_1.var_.characterEffect1028ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1028ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1028ui_story then
				arg_61_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_64_4 = 0
			local var_64_5 = 0.35

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(318161015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 14 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 14)

				if (14 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 14)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161015", "story_v_out_318161.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161015", "story_v_out_318161.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_318161", "318161015", "story_v_out_318161.awb")

						arg_61_1:RecordAudio("318161015", var_64_11)
						arg_61_1:RecordAudio("318161015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_318161", "318161015", "story_v_out_318161.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_318161", "318161015", "story_v_out_318161.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play318161016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 318161016
		arg_65_1.duration_ = 8.4

		local var_65_0 = {
			zh = 5.066,
			ja = 8.4
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play318161017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1028ui_story"]) and arg_65_1.var_.characterEffect1028ui_story == nil then
				arg_65_1.var_.characterEffect1028ui_story = arg_65_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1028ui_story"]) then
				if arg_65_1.var_.characterEffect1028ui_story and not isNil(arg_65_1.actors_["1028ui_story"]) then
					arg_65_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1028ui_story"]) and arg_65_1.var_.characterEffect1028ui_story then
				arg_65_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1019ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1019ui_story == nil then
				arg_65_1.var_.characterEffect1019ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1019ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1019ui_story then
				arg_65_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.675

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(318161016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 27 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 27)

				if (27 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 27)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161016", "story_v_out_318161.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161016", "story_v_out_318161.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_318161", "318161016", "story_v_out_318161.awb")

						arg_65_1:RecordAudio("318161016", var_68_11)
						arg_65_1:RecordAudio("318161016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_318161", "318161016", "story_v_out_318161.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_318161", "318161016", "story_v_out_318161.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play318161017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 318161017
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play318161018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1019ui_story"]) and arg_69_1.var_.characterEffect1019ui_story == nil then
				arg_69_1.var_.characterEffect1019ui_story = arg_69_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1019ui_story"]) then
				if arg_69_1.var_.characterEffect1019ui_story and not isNil(arg_69_1.actors_["1019ui_story"]) then
					arg_69_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1019ui_story"]) and arg_69_1.var_.characterEffect1019ui_story then
				arg_69_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_72_2 = arg_69_1.actors_["1028ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1028ui_story == nil then
				arg_69_1.var_.characterEffect1028ui_story = var_72_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_3 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.characterEffect1028ui_story and not isNil(var_72_2) then
					arg_69_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_3)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1028ui_story then
				arg_69_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_72_4 = 0
			local var_72_5 = 0.075

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(318161017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 3 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 3)

				if (3 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 3)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161017", "story_v_out_318161.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161017", "story_v_out_318161.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_318161", "318161017", "story_v_out_318161.awb")

						arg_69_1:RecordAudio("318161017", var_72_11)
						arg_69_1:RecordAudio("318161017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_318161", "318161017", "story_v_out_318161.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_318161", "318161017", "story_v_out_318161.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play318161018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 318161018
		arg_73_1.duration_ = 4.5

		local var_73_0 = {
			zh = 4.5,
			ja = 2.5
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play318161019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1028ui_story"]) and arg_73_1.var_.characterEffect1028ui_story == nil then
				arg_73_1.var_.characterEffect1028ui_story = arg_73_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1028ui_story"]) then
				if arg_73_1.var_.characterEffect1028ui_story and not isNil(arg_73_1.actors_["1028ui_story"]) then
					arg_73_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1028ui_story"]) and arg_73_1.var_.characterEffect1028ui_story then
				arg_73_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_76_2 = arg_73_1.actors_["1019ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1019ui_story == nil then
				arg_73_1.var_.characterEffect1019ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect1019ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1019ui_story then
				arg_73_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_76_4 = 0
			local var_76_5 = 0.35

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(318161018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 14 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 14)

				if (14 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 14)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161018", "story_v_out_318161.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161018", "story_v_out_318161.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_318161", "318161018", "story_v_out_318161.awb")

						arg_73_1:RecordAudio("318161018", var_76_11)
						arg_73_1:RecordAudio("318161018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_318161", "318161018", "story_v_out_318161.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_318161", "318161018", "story_v_out_318161.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play318161019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318161019
		arg_77_1.duration_ = 12.1

		local var_77_0 = {
			zh = 7.2,
			ja = 12.1
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play318161020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1019ui_story"]) and arg_77_1.var_.characterEffect1019ui_story == nil then
				arg_77_1.var_.characterEffect1019ui_story = arg_77_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1019ui_story"]) then
				if arg_77_1.var_.characterEffect1019ui_story and not isNil(arg_77_1.actors_["1019ui_story"]) then
					arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1019ui_story"]) and arg_77_1.var_.characterEffect1019ui_story then
				arg_77_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_80_2 = arg_77_1.actors_["1028ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1028ui_story == nil then
				arg_77_1.var_.characterEffect1028ui_story = var_80_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.characterEffect1028ui_story and not isNil(var_80_2) then
					arg_77_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_3)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1028ui_story then
				arg_77_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_80_4 = 0
			local var_80_5 = 0.775

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(318161019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 31 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 31)

				if (31 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 31)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161019", "story_v_out_318161.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161019", "story_v_out_318161.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_318161", "318161019", "story_v_out_318161.awb")

						arg_77_1:RecordAudio("318161019", var_80_11)
						arg_77_1:RecordAudio("318161019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_318161", "318161019", "story_v_out_318161.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_318161", "318161019", "story_v_out_318161.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play318161020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318161020
		arg_81_1.duration_ = 6.47

		local var_81_0 = {
			zh = 2.6,
			ja = 6.466
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play318161021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1019ui_story"]) and arg_81_1.var_.characterEffect1019ui_story == nil then
				arg_81_1.var_.characterEffect1019ui_story = arg_81_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1019ui_story"]) then
				if arg_81_1.var_.characterEffect1019ui_story and not isNil(arg_81_1.actors_["1019ui_story"]) then
					arg_81_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1019ui_story"]) and arg_81_1.var_.characterEffect1019ui_story then
				arg_81_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_84_2 = 0
			local var_84_3 = 0.35

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(318161020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 14 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 14)

				if (14 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 14)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161020", "story_v_out_318161.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161020", "story_v_out_318161.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_318161", "318161020", "story_v_out_318161.awb")

						arg_81_1:RecordAudio("318161020", var_84_9)
						arg_81_1:RecordAudio("318161020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_318161", "318161020", "story_v_out_318161.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_318161", "318161020", "story_v_out_318161.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play318161021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 318161021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play318161022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1019ui_story"]) and arg_85_1.var_.characterEffect1019ui_story == nil then
				arg_85_1.var_.characterEffect1019ui_story = arg_85_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1019ui_story"]) then
				if arg_85_1.var_.characterEffect1019ui_story and not isNil(arg_85_1.actors_["1019ui_story"]) then
					arg_85_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1019ui_story"]) and arg_85_1.var_.characterEffect1019ui_story then
				arg_85_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_88_1 = 0
			local var_88_2 = 1.3

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(318161021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 52 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 52)

				if (52 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 52)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play318161022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 318161022
		arg_89_1.duration_ = 5.33

		local var_89_0 = {
			zh = 5.333,
			ja = 4.766
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play318161023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1028ui_story"]) and arg_89_1.var_.characterEffect1028ui_story == nil then
				arg_89_1.var_.characterEffect1028ui_story = arg_89_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1028ui_story"]) then
				if arg_89_1.var_.characterEffect1028ui_story and not isNil(arg_89_1.actors_["1028ui_story"]) then
					arg_89_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1028ui_story"]) and arg_89_1.var_.characterEffect1028ui_story then
				arg_89_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_2 = 0
			local var_92_3 = 0.6

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:GetWordFromCfg(318161022)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 24 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 24)

				if (24 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 24)) > 0 and var_92_3 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161022", "story_v_out_318161.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161022", "story_v_out_318161.awb") / 1000

					if var_92_8 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_2
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_out_318161", "318161022", "story_v_out_318161.awb")

						arg_89_1:RecordAudio("318161022", var_92_9)
						arg_89_1:RecordAudio("318161022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_318161", "318161022", "story_v_out_318161.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_318161", "318161022", "story_v_out_318161.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_10 and arg_89_1.time_ < var_92_2 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play318161023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318161023
		arg_93_1.duration_ = 7.37

		local var_93_0 = {
			zh = 5.466,
			ja = 7.366
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play318161024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1019ui_story"]) and arg_93_1.var_.characterEffect1019ui_story == nil then
				arg_93_1.var_.characterEffect1019ui_story = arg_93_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1019ui_story"]) then
				if arg_93_1.var_.characterEffect1019ui_story and not isNil(arg_93_1.actors_["1019ui_story"]) then
					arg_93_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1019ui_story"]) and arg_93_1.var_.characterEffect1019ui_story then
				arg_93_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_96_2 = arg_93_1.actors_["1028ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1028ui_story == nil then
				arg_93_1.var_.characterEffect1028ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.characterEffect1028ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_3)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1028ui_story then
				arg_93_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_96_4 = 0
			local var_96_5 = 0.6

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(318161023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 24 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 24)

				if (24 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 24)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161023", "story_v_out_318161.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161023", "story_v_out_318161.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_318161", "318161023", "story_v_out_318161.awb")

						arg_93_1:RecordAudio("318161023", var_96_11)
						arg_93_1:RecordAudio("318161023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_318161", "318161023", "story_v_out_318161.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_318161", "318161023", "story_v_out_318161.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play318161024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 318161024
		arg_97_1.duration_ = 8.6

		local var_97_0 = {
			zh = 8.6,
			ja = 5.833
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play318161025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.15

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(318161024)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 46 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 46)

				if (46 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 46)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161024", "story_v_out_318161.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_318161", "318161024", "story_v_out_318161.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_318161", "318161024", "story_v_out_318161.awb")

						arg_97_1:RecordAudio("318161024", var_100_6)
						arg_97_1:RecordAudio("318161024", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_318161", "318161024", "story_v_out_318161.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_318161", "318161024", "story_v_out_318161.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play318161025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 318161025
		arg_101_1.duration_ = 8.27

		local var_101_0 = {
			zh = 8.266,
			ja = 6.666
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play318161026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.85

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(318161025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 34 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 34)

				if (34 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 34)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161025", "story_v_out_318161.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_318161", "318161025", "story_v_out_318161.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_318161", "318161025", "story_v_out_318161.awb")

						arg_101_1:RecordAudio("318161025", var_104_6)
						arg_101_1:RecordAudio("318161025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_318161", "318161025", "story_v_out_318161.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_318161", "318161025", "story_v_out_318161.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play318161026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 318161026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play318161027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1019ui_story"]) and arg_105_1.var_.characterEffect1019ui_story == nil then
				arg_105_1.var_.characterEffect1019ui_story = arg_105_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1019ui_story"]) then
				if arg_105_1.var_.characterEffect1019ui_story and not isNil(arg_105_1.actors_["1019ui_story"]) then
					arg_105_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1019ui_story"]) and arg_105_1.var_.characterEffect1019ui_story then
				arg_105_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 1.075

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(318161026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 43 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 43)

				if (43 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 43)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play318161027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 318161027
		arg_109_1.duration_ = 8.03

		local var_109_0 = {
			zh = 3.6,
			ja = 8.033
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play318161028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1028ui_story"]) and arg_109_1.var_.characterEffect1028ui_story == nil then
				arg_109_1.var_.characterEffect1028ui_story = arg_109_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1028ui_story"]) then
				if arg_109_1.var_.characterEffect1028ui_story and not isNil(arg_109_1.actors_["1028ui_story"]) then
					arg_109_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1028ui_story"]) and arg_109_1.var_.characterEffect1028ui_story then
				arg_109_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.45

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(318161027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 18 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 18)

				if (18 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 18)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161027", "story_v_out_318161.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161027", "story_v_out_318161.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_318161", "318161027", "story_v_out_318161.awb")

						arg_109_1:RecordAudio("318161027", var_112_9)
						arg_109_1:RecordAudio("318161027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_318161", "318161027", "story_v_out_318161.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_318161", "318161027", "story_v_out_318161.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play318161028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 318161028
		arg_113_1.duration_ = 10.7

		local var_113_0 = {
			zh = 3.866,
			ja = 10.7
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play318161029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1019ui_story"]) and arg_113_1.var_.characterEffect1019ui_story == nil then
				arg_113_1.var_.characterEffect1019ui_story = arg_113_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1019ui_story"]) then
				if arg_113_1.var_.characterEffect1019ui_story and not isNil(arg_113_1.actors_["1019ui_story"]) then
					arg_113_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1019ui_story"]) and arg_113_1.var_.characterEffect1019ui_story then
				arg_113_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_116_2 = arg_113_1.actors_["1028ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1028ui_story == nil then
				arg_113_1.var_.characterEffect1028ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_3 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.characterEffect1028ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_3)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1028ui_story then
				arg_113_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_116_4 = 0
			local var_116_5 = 0.575

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(318161028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 23 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 23)

				if (23 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 23)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161028", "story_v_out_318161.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161028", "story_v_out_318161.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_318161", "318161028", "story_v_out_318161.awb")

						arg_113_1:RecordAudio("318161028", var_116_11)
						arg_113_1:RecordAudio("318161028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_318161", "318161028", "story_v_out_318161.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_318161", "318161028", "story_v_out_318161.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play318161029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 318161029
		arg_117_1.duration_ = 9.13

		local var_117_0 = {
			zh = 8.6,
			ja = 9.133
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play318161030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1028ui_story"]) and arg_117_1.var_.characterEffect1028ui_story == nil then
				arg_117_1.var_.characterEffect1028ui_story = arg_117_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1028ui_story"]) then
				if arg_117_1.var_.characterEffect1028ui_story and not isNil(arg_117_1.actors_["1028ui_story"]) then
					arg_117_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1028ui_story"]) and arg_117_1.var_.characterEffect1028ui_story then
				arg_117_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			local var_120_2 = arg_117_1.actors_["1019ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1019ui_story == nil then
				arg_117_1.var_.characterEffect1019ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1019ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1019ui_story then
				arg_117_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.85

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(318161029)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 34 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 34)

				if (34 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 34)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161029", "story_v_out_318161.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161029", "story_v_out_318161.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_318161", "318161029", "story_v_out_318161.awb")

						arg_117_1:RecordAudio("318161029", var_120_11)
						arg_117_1:RecordAudio("318161029", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_318161", "318161029", "story_v_out_318161.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_318161", "318161029", "story_v_out_318161.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play318161030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 318161030
		arg_121_1.duration_ = 7.43

		local var_121_0 = {
			zh = 7.433,
			ja = 7.1
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play318161031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1019ui_story"]) and arg_121_1.var_.characterEffect1019ui_story == nil then
				arg_121_1.var_.characterEffect1019ui_story = arg_121_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1019ui_story"]) then
				if arg_121_1.var_.characterEffect1019ui_story and not isNil(arg_121_1.actors_["1019ui_story"]) then
					arg_121_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1019ui_story"]) and arg_121_1.var_.characterEffect1019ui_story then
				arg_121_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_124_2 = arg_121_1.actors_["1028ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1028ui_story == nil then
				arg_121_1.var_.characterEffect1028ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1028ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1028ui_story then
				arg_121_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(318161030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 40 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 40)

				if (40 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 40)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161030", "story_v_out_318161.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161030", "story_v_out_318161.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_318161", "318161030", "story_v_out_318161.awb")

						arg_121_1:RecordAudio("318161030", var_124_11)
						arg_121_1:RecordAudio("318161030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_318161", "318161030", "story_v_out_318161.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_318161", "318161030", "story_v_out_318161.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play318161031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318161031
		arg_125_1.duration_ = 9.13

		local var_125_0 = {
			zh = 6.2,
			ja = 9.133
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play318161032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.725

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(318161031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 29 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 29)

				if (29 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 29)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161031", "story_v_out_318161.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_318161", "318161031", "story_v_out_318161.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_318161", "318161031", "story_v_out_318161.awb")

						arg_125_1:RecordAudio("318161031", var_128_6)
						arg_125_1:RecordAudio("318161031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_318161", "318161031", "story_v_out_318161.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_318161", "318161031", "story_v_out_318161.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play318161032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318161032
		arg_129_1.duration_ = 8.63

		local var_129_0 = {
			zh = 8.633,
			ja = 7.466
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play318161033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1028ui_story"]) and arg_129_1.var_.characterEffect1028ui_story == nil then
				arg_129_1.var_.characterEffect1028ui_story = arg_129_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1028ui_story"]) then
				if arg_129_1.var_.characterEffect1028ui_story and not isNil(arg_129_1.actors_["1028ui_story"]) then
					arg_129_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1028ui_story"]) and arg_129_1.var_.characterEffect1028ui_story then
				arg_129_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028actionlink/1028action475")
			end

			local var_132_2 = arg_129_1.actors_["1019ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1019ui_story == nil then
				arg_129_1.var_.characterEffect1019ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1019ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1019ui_story then
				arg_129_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_132_4 = 0
			local var_132_5 = 0.575

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(318161032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 23 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 23)

				if (23 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 23)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161032", "story_v_out_318161.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161032", "story_v_out_318161.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_318161", "318161032", "story_v_out_318161.awb")

						arg_129_1:RecordAudio("318161032", var_132_11)
						arg_129_1:RecordAudio("318161032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_318161", "318161032", "story_v_out_318161.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_318161", "318161032", "story_v_out_318161.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play318161033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318161033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play318161034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1028ui_story"]) and arg_133_1.var_.characterEffect1028ui_story == nil then
				arg_133_1.var_.characterEffect1028ui_story = arg_133_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1028ui_story"]) then
				if arg_133_1.var_.characterEffect1028ui_story and not isNil(arg_133_1.actors_["1028ui_story"]) then
					arg_133_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1028ui_story"]) and arg_133_1.var_.characterEffect1028ui_story then
				arg_133_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.575

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(318161033).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 23 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 23)

				if (23 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 23)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play318161034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318161034
		arg_137_1.duration_ = 6.6

		local var_137_0 = {
			zh = 5.966,
			ja = 6.6
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play318161035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1028ui_story"]) and arg_137_1.var_.characterEffect1028ui_story == nil then
				arg_137_1.var_.characterEffect1028ui_story = arg_137_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1028ui_story"]) then
				if arg_137_1.var_.characterEffect1028ui_story and not isNil(arg_137_1.actors_["1028ui_story"]) then
					arg_137_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1028ui_story"]) and arg_137_1.var_.characterEffect1028ui_story then
				arg_137_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_2")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_2 = 0
			local var_140_3 = 0.825

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(318161034)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 33 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 33)

				if (33 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 33)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161034", "story_v_out_318161.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161034", "story_v_out_318161.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_out_318161", "318161034", "story_v_out_318161.awb")

						arg_137_1:RecordAudio("318161034", var_140_9)
						arg_137_1:RecordAudio("318161034", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_318161", "318161034", "story_v_out_318161.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_318161", "318161034", "story_v_out_318161.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_10 and arg_137_1.time_ < var_140_2 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play318161035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318161035
		arg_141_1.duration_ = 9.3

		local var_141_0 = {
			zh = 4.533,
			ja = 9.3
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play318161036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1019ui_story"]) and arg_141_1.var_.characterEffect1019ui_story == nil then
				arg_141_1.var_.characterEffect1019ui_story = arg_141_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1019ui_story"]) then
				if arg_141_1.var_.characterEffect1019ui_story and not isNil(arg_141_1.actors_["1019ui_story"]) then
					arg_141_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1019ui_story"]) and arg_141_1.var_.characterEffect1019ui_story then
				arg_141_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_2 = arg_141_1.actors_["1028ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1028ui_story == nil then
				arg_141_1.var_.characterEffect1028ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect1028ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1028ui_story then
				arg_141_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_144_4 = 0
			local var_144_5 = 0.625

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(318161035)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 25 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 25)

				if (25 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 25)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161035", "story_v_out_318161.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161035", "story_v_out_318161.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_318161", "318161035", "story_v_out_318161.awb")

						arg_141_1:RecordAudio("318161035", var_144_11)
						arg_141_1:RecordAudio("318161035", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_318161", "318161035", "story_v_out_318161.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_318161", "318161035", "story_v_out_318161.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play318161036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318161036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play318161037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1019ui_story"]) and arg_145_1.var_.characterEffect1019ui_story == nil then
				arg_145_1.var_.characterEffect1019ui_story = arg_145_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1019ui_story"]) then
				if arg_145_1.var_.characterEffect1019ui_story and not isNil(arg_145_1.actors_["1019ui_story"]) then
					arg_145_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1019ui_story"]) and arg_145_1.var_.characterEffect1019ui_story then
				arg_145_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.675

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(318161036).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 27 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 27)

				if (27 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 27)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play318161037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318161037
		arg_149_1.duration_ = 6.7

		local var_149_0 = {
			zh = 6.7,
			ja = 5.033
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play318161038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1028ui_story"]) and arg_149_1.var_.characterEffect1028ui_story == nil then
				arg_149_1.var_.characterEffect1028ui_story = arg_149_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1028ui_story"]) then
				if arg_149_1.var_.characterEffect1028ui_story and not isNil(arg_149_1.actors_["1028ui_story"]) then
					arg_149_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1028ui_story"]) and arg_149_1.var_.characterEffect1028ui_story then
				arg_149_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_152_2 = 0
			local var_152_3 = 0.775

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_4 = arg_149_1:GetWordFromCfg(318161037)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 31 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 31)

				if (31 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 31)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161037", "story_v_out_318161.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161037", "story_v_out_318161.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_out_318161", "318161037", "story_v_out_318161.awb")

						arg_149_1:RecordAudio("318161037", var_152_9)
						arg_149_1:RecordAudio("318161037", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_318161", "318161037", "story_v_out_318161.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_318161", "318161037", "story_v_out_318161.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play318161038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318161038
		arg_153_1.duration_ = 12.1

		local var_153_0 = {
			zh = 9.266,
			ja = 12.1
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play318161039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.175

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(318161038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 47 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 47)

				if (47 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 47)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161038", "story_v_out_318161.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_318161", "318161038", "story_v_out_318161.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_318161", "318161038", "story_v_out_318161.awb")

						arg_153_1:RecordAudio("318161038", var_156_6)
						arg_153_1:RecordAudio("318161038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_318161", "318161038", "story_v_out_318161.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_318161", "318161038", "story_v_out_318161.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play318161039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318161039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318161040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1028ui_story"]) and arg_157_1.var_.characterEffect1028ui_story == nil then
				arg_157_1.var_.characterEffect1028ui_story = arg_157_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1028ui_story"]) then
				if arg_157_1.var_.characterEffect1028ui_story and not isNil(arg_157_1.actors_["1028ui_story"]) then
					arg_157_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1028ui_story"]) and arg_157_1.var_.characterEffect1028ui_story then
				arg_157_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 0.95

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(318161039).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 38 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 38)

				if (38 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 38)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play318161040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318161040
		arg_161_1.duration_ = 7.63

		local var_161_0 = {
			zh = 7.633,
			ja = 5.133
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play318161041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1019ui_story"]) and arg_161_1.var_.characterEffect1019ui_story == nil then
				arg_161_1.var_.characterEffect1019ui_story = arg_161_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1019ui_story"]) then
				if arg_161_1.var_.characterEffect1019ui_story and not isNil(arg_161_1.actors_["1019ui_story"]) then
					arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1019ui_story"]) and arg_161_1.var_.characterEffect1019ui_story then
				arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_164_2 = 0
			local var_164_3 = 0.75

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_4 = arg_161_1:GetWordFromCfg(318161040)
				local var_164_5 = arg_161_1:FormatText(var_164_4.content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 30 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 30)

				if (30 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 30)) > 0 and var_164_3 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161040", "story_v_out_318161.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161040", "story_v_out_318161.awb") / 1000

					if var_164_8 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_2
					end

					if var_164_4.prefab_name ~= "" and arg_161_1.actors_[var_164_4.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_4.prefab_name].transform, "story_v_out_318161", "318161040", "story_v_out_318161.awb")

						arg_161_1:RecordAudio("318161040", var_164_9)
						arg_161_1:RecordAudio("318161040", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_318161", "318161040", "story_v_out_318161.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_318161", "318161040", "story_v_out_318161.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_10 and arg_161_1.time_ < var_164_2 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play318161041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 318161041
		arg_165_1.duration_ = 5.6

		local var_165_0 = {
			zh = 1.5,
			ja = 5.6
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play318161042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.15

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(318161041)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 6 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 6)

				if (6 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 6)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161041", "story_v_out_318161.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_318161", "318161041", "story_v_out_318161.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_318161", "318161041", "story_v_out_318161.awb")

						arg_165_1:RecordAudio("318161041", var_168_6)
						arg_165_1:RecordAudio("318161041", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_318161", "318161041", "story_v_out_318161.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_318161", "318161041", "story_v_out_318161.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play318161042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 318161042
		arg_169_1.duration_ = 9

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play318161043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if arg_169_1.bgs_.ST12 == nil then
				local var_172_0 = Object.Instantiate(arg_169_1.paintGo_)

				var_172_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_172_0.name = "ST12"
				var_172_0.transform.parent = arg_169_1.stage_.transform
				var_172_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.bgs_.ST12 = var_172_0
			end

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= 2 + arg_172_0 then
				local var_172_1 = arg_169_1.bgs_.ST12

				arg_169_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_172_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_172_2 = var_172_1:GetComponent("SpriteRenderer")

				if var_172_2 and var_172_2.sprite then
					local var_172_3 = 2 * (var_172_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_172_1.transform.localScale = Vector3.New(var_172_3 / var_172_2.sprite.bounds.size.y < var_172_3 * manager.ui.mainCameraCom_.aspect / var_172_2.sprite.bounds.size.x and var_172_3 * manager.ui.mainCameraCom_.aspect / var_172_2.sprite.bounds.size.x or var_172_3 / var_172_2.sprite.bounds.size.y, var_172_3 / var_172_2.sprite.bounds.size.y < var_172_3 * manager.ui.mainCameraCom_.aspect / var_172_2.sprite.bounds.size.x and var_172_3 * manager.ui.mainCameraCom_.aspect / var_172_2.sprite.bounds.size.x or var_172_3 / var_172_2.sprite.bounds.size.y, 0)
				end

				for iter_172_0, iter_172_1 in pairs(arg_169_1.bgs_) do
					if iter_172_0 ~= "ST12" then
						iter_172_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_172_4 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_5 = 2

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_5 then
				local var_172_6 = Color.New(0, 0, 0)

				var_172_6.a = Mathf.Lerp(0, 1, (arg_169_1.time_ - var_172_4) / var_172_5)
				arg_169_1.mask_.color = var_172_6
			end

			if arg_169_1.time_ >= var_172_4 + var_172_5 and arg_169_1.time_ < var_172_4 + var_172_5 + arg_172_0 then
				local var_172_7 = Color.New(0, 0, 0)

				var_172_7.a = 1
				arg_169_1.mask_.color = var_172_7
			end

			local var_172_8 = 2

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_9 = 2

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 then
				local var_172_10 = Color.New(0, 0, 0)

				var_172_10.a = Mathf.Lerp(1, 0, (arg_169_1.time_ - var_172_8) / var_172_9)
				arg_169_1.mask_.color = var_172_10
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 then
				local var_172_11 = Color.New(0, 0, 0)

				arg_169_1.mask_.enabled = false
				var_172_11.a = 0
				arg_169_1.mask_.color = var_172_11
			end

			local var_172_12 = arg_169_1.actors_["1019ui_story"].transform

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= 2 + arg_172_0 then
				arg_169_1.var_.moveOldPos1019ui_story = var_172_12.localPosition
			end

			local var_172_13 = 0.001

			if 2 <= arg_169_1.time_ and arg_169_1.time_ < 2 + var_172_13 then
				var_172_12.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 2) / var_172_13)
				var_172_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_12.position).x, (manager.ui.mainCamera.transform.position - var_172_12.position).y, (manager.ui.mainCamera.transform.position - var_172_12.position).z)
				var_172_12.localEulerAngles.z = 0
				var_172_12.localEulerAngles.x = 0
				var_172_12.localEulerAngles = var_172_12.localEulerAngles
			end

			if arg_169_1.time_ >= 2 + var_172_13 and arg_169_1.time_ < 2 + var_172_13 + arg_172_0 then
				var_172_12.localPosition = Vector3.New(0, 100, 0)
				var_172_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_12.position).x, (manager.ui.mainCamera.transform.position - var_172_12.position).y, (manager.ui.mainCamera.transform.position - var_172_12.position).z)
				var_172_12.localEulerAngles.z = 0
				var_172_12.localEulerAngles.x = 0
				var_172_12.localEulerAngles = var_172_12.localEulerAngles
			end

			local var_172_14 = arg_169_1.actors_["1019ui_story"]

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= 2 + arg_172_0 and not isNil(var_172_14) and arg_169_1.var_.characterEffect1019ui_story == nil then
				arg_169_1.var_.characterEffect1019ui_story = var_172_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_15 = 0.200000002980232

			if 2 <= arg_169_1.time_ and arg_169_1.time_ < 2 + var_172_15 and not isNil(var_172_14) then
				if arg_169_1.var_.characterEffect1019ui_story and not isNil(var_172_14) then
					arg_169_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 2) / var_172_15)
				end
			end

			if arg_169_1.time_ >= 2 + var_172_15 and arg_169_1.time_ < 2 + var_172_15 + arg_172_0 and not isNil(var_172_14) and arg_169_1.var_.characterEffect1019ui_story then
				arg_169_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_172_16 = arg_169_1.actors_["1028ui_story"].transform

			if 2 < arg_169_1.time_ and arg_169_1.time_ <= 2 + arg_172_0 then
				arg_169_1.var_.moveOldPos1028ui_story = var_172_16.localPosition
			end

			local var_172_17 = 0.001

			if 2 <= arg_169_1.time_ and arg_169_1.time_ < 2 + var_172_17 then
				var_172_16.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 2) / var_172_17)
				var_172_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_16.position).x, (manager.ui.mainCamera.transform.position - var_172_16.position).y, (manager.ui.mainCamera.transform.position - var_172_16.position).z)
				var_172_16.localEulerAngles.z = 0
				var_172_16.localEulerAngles.x = 0
				var_172_16.localEulerAngles = var_172_16.localEulerAngles
			end

			if arg_169_1.time_ >= 2 + var_172_17 and arg_169_1.time_ < 2 + var_172_17 + arg_172_0 then
				var_172_16.localPosition = Vector3.New(0, 100, 0)
				var_172_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_16.position).x, (manager.ui.mainCamera.transform.position - var_172_16.position).y, (manager.ui.mainCamera.transform.position - var_172_16.position).z)
				var_172_16.localEulerAngles.z = 0
				var_172_16.localEulerAngles.x = 0
				var_172_16.localEulerAngles = var_172_16.localEulerAngles
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_18 = 4
			local var_172_19 = 0.475

			if 4 < arg_169_1.time_ and arg_169_1.time_ <= var_172_18 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_20 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_20:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_21 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(318161042).content)

				arg_169_1.text_.text = var_172_21

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_23 = 19 <= 0 and var_172_19 or var_172_19 * (utf8.len(var_172_21) / 19)

				if (19 <= 0 and var_172_19 or var_172_19 * (utf8.len(var_172_21) / 19)) > 0 and var_172_19 < var_172_23 then
					arg_169_1.talkMaxDuration = var_172_23
					var_172_18 = var_172_18 + 0.3

					if var_172_23 + var_172_18 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_23 + var_172_18
					end
				end

				arg_169_1.text_.text = var_172_21
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_24 = var_172_18 + 0.3
			local var_172_25 = math.max(var_172_19, arg_169_1.talkMaxDuration)

			if var_172_18 + 0.3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_24 + var_172_25 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_24) / var_172_25

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_24 + var_172_25 and arg_169_1.time_ < var_172_24 + var_172_25 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play318161043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 318161043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play318161044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.825

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(318161043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 33 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 33)

				if (33 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 33)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play318161044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 318161044
		arg_179_1.duration_ = 9.73

		local var_179_0 = {
			zh = 9.733,
			ja = 7.666
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play318161045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1019ui_story = arg_179_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1019ui_story"].transform.position).z)
				arg_179_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1019ui_story"].transform.localEulerAngles = arg_179_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_179_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1019ui_story"].transform.position).z)
				arg_179_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1019ui_story"].transform.localEulerAngles = arg_179_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1019ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1019ui_story == nil then
				arg_179_1.var_.characterEffect1019ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1019ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1019ui_story then
				arg_179_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_182_4 = 0
			local var_182_5 = 0.85

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(318161044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 34 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 34)

				if (34 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 34)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161044", "story_v_out_318161.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161044", "story_v_out_318161.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_318161", "318161044", "story_v_out_318161.awb")

						arg_179_1:RecordAudio("318161044", var_182_11)
						arg_179_1:RecordAudio("318161044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_318161", "318161044", "story_v_out_318161.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_318161", "318161044", "story_v_out_318161.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play318161045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 318161045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play318161046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1019ui_story"]) and arg_183_1.var_.characterEffect1019ui_story == nil then
				arg_183_1.var_.characterEffect1019ui_story = arg_183_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1019ui_story"]) then
				if arg_183_1.var_.characterEffect1019ui_story and not isNil(arg_183_1.actors_["1019ui_story"]) then
					arg_183_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1019ui_story"]) and arg_183_1.var_.characterEffect1019ui_story then
				arg_183_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.975

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(318161045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 39 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 39)

				if (39 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 39)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play318161046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 318161046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play318161047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.05

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(318161046).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 42 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 42)

				if (42 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 42)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play318161047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 318161047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play318161048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:AudioAction("play", "effect", "se_story_17", "se_story_17_ui", "")
			end

			local var_194_1 = 0
			local var_194_2 = 0.775

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(318161047).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 31 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 31)

				if (31 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 31)) > 0 and var_194_2 < var_194_5 then
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
	Play318161048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 318161048
		arg_195_1.duration_ = 2.67

		local var_195_0 = {
			zh = 2.666,
			ja = 2.633
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
				arg_195_0:Play318161049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1019ui_story"]) and arg_195_1.var_.characterEffect1019ui_story == nil then
				arg_195_1.var_.characterEffect1019ui_story = arg_195_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1019ui_story"]) then
				if arg_195_1.var_.characterEffect1019ui_story and not isNil(arg_195_1.actors_["1019ui_story"]) then
					arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1019ui_story"]) and arg_195_1.var_.characterEffect1019ui_story then
				arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_198_2 = 0
			local var_198_3 = 0.2

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:GetWordFromCfg(318161048)
				local var_198_5 = arg_195_1:FormatText(var_198_4.content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 8 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 8)

				if (8 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 8)) > 0 and var_198_3 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_2
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161048", "story_v_out_318161.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161048", "story_v_out_318161.awb") / 1000

					if var_198_8 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_2
					end

					if var_198_4.prefab_name ~= "" and arg_195_1.actors_[var_198_4.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_4.prefab_name].transform, "story_v_out_318161", "318161048", "story_v_out_318161.awb")

						arg_195_1:RecordAudio("318161048", var_198_9)
						arg_195_1:RecordAudio("318161048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_318161", "318161048", "story_v_out_318161.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_318161", "318161048", "story_v_out_318161.awb")
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
	Play318161049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 318161049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play318161050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1019ui_story"]) and arg_199_1.var_.characterEffect1019ui_story == nil then
				arg_199_1.var_.characterEffect1019ui_story = arg_199_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1019ui_story"]) then
				if arg_199_1.var_.characterEffect1019ui_story and not isNil(arg_199_1.actors_["1019ui_story"]) then
					arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1019ui_story"]) and arg_199_1.var_.characterEffect1019ui_story then
				arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.675

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(318161049).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 27 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 27)

				if (27 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 27)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play318161050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 318161050
		arg_203_1.duration_ = 9.9

		local var_203_0 = {
			zh = 9.9,
			ja = 8.2
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play318161051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1019ui_story = arg_203_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).z)
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles = arg_203_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_203_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).z)
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles = arg_203_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1019ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1019ui_story == nil then
				arg_203_1.var_.characterEffect1019ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1019ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1019ui_story then
				arg_203_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_206_4 = 0
			local var_206_5 = 0.95

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(318161050)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 38 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 38)

				if (38 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 38)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161050", "story_v_out_318161.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161050", "story_v_out_318161.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_318161", "318161050", "story_v_out_318161.awb")

						arg_203_1:RecordAudio("318161050", var_206_11)
						arg_203_1:RecordAudio("318161050", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_318161", "318161050", "story_v_out_318161.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_318161", "318161050", "story_v_out_318161.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play318161051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 318161051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play318161052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1019ui_story = arg_207_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1019ui_story"].transform.position).z)
				arg_207_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1019ui_story"].transform.localEulerAngles = arg_207_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1019ui_story"].transform.position).z)
				arg_207_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1019ui_story"].transform.localEulerAngles = arg_207_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1019ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1019ui_story == nil then
				arg_207_1.var_.characterEffect1019ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1019ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_2)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1019ui_story then
				arg_207_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_210_3 = 0
			local var_210_4 = 0.675

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_3 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_5 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(318161051).content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 27 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_5) / 27)

				if (27 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_5) / 27)) > 0 and var_210_4 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_3 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_3
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_4, arg_207_1.talkMaxDuration)

			if var_210_3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_3 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_3) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_3 + var_210_8 and arg_207_1.time_ < var_210_3 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play318161052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 318161052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play318161053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.25

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

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(318161052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 10 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 10)

				if (10 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 10)) > 0 and var_214_0 < var_214_3 then
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
	Play318161053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 318161053
		arg_215_1.duration_ = 2

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play318161054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1019ui_story = arg_215_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1019ui_story"].transform.position).z)
				arg_215_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1019ui_story"].transform.localEulerAngles = arg_215_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_215_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1019ui_story"].transform.position).z)
				arg_215_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1019ui_story"].transform.localEulerAngles = arg_215_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1019ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1019ui_story == nil then
				arg_215_1.var_.characterEffect1019ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1019ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1019ui_story then
				arg_215_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_218_4 = 0
			local var_218_5 = 0.175

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(318161053)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 7 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 7)

				if (7 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 7)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161053", "story_v_out_318161.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161053", "story_v_out_318161.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_318161", "318161053", "story_v_out_318161.awb")

						arg_215_1:RecordAudio("318161053", var_218_11)
						arg_215_1:RecordAudio("318161053", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_318161", "318161053", "story_v_out_318161.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_318161", "318161053", "story_v_out_318161.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play318161054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 318161054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play318161055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1019ui_story"]) and arg_219_1.var_.characterEffect1019ui_story == nil then
				arg_219_1.var_.characterEffect1019ui_story = arg_219_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1019ui_story"]) then
				if arg_219_1.var_.characterEffect1019ui_story and not isNil(arg_219_1.actors_["1019ui_story"]) then
					arg_219_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1019ui_story"]) and arg_219_1.var_.characterEffect1019ui_story then
				arg_219_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_222_1 = "1033ui_story"

			if arg_219_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_222_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_219_1.stage_.transform)

				var_222_2.name = var_222_1
				var_222_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_[var_222_1] = var_222_2

				local var_222_3 = var_222_2:GetComponentInChildren(typeof(CharacterEffect))

				var_222_3.enabled = true

				local var_222_4 = GameObjectTools.GetOrAddComponent(var_222_2, typeof(DynamicBoneHelper))

				if var_222_4 then
					var_222_4:EnableDynamicBone(false)
				end

				arg_219_1:ShowWeapon(var_222_3.transform, false)

				arg_219_1.var_[var_222_1 .. "Animator"] = var_222_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_219_1.var_[var_222_1 .. "Animator"].applyRootMotion = true
				arg_219_1.var_[var_222_1 .. "LipSync"] = var_222_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_222_5 = arg_219_1.actors_["1033ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1033ui_story = var_222_5.localPosition
			end

			local var_222_6 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_6 then
				var_222_5.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_219_1.time_ - 0) / var_222_6)
				var_222_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_5.position).x, (manager.ui.mainCamera.transform.position - var_222_5.position).y, (manager.ui.mainCamera.transform.position - var_222_5.position).z)
				var_222_5.localEulerAngles.z = 0
				var_222_5.localEulerAngles.x = 0
				var_222_5.localEulerAngles = var_222_5.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_6 and arg_219_1.time_ < 0 + var_222_6 + arg_222_0 then
				var_222_5.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_222_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_5.position).x, (manager.ui.mainCamera.transform.position - var_222_5.position).y, (manager.ui.mainCamera.transform.position - var_222_5.position).z)
				var_222_5.localEulerAngles.z = 0
				var_222_5.localEulerAngles.x = 0
				var_222_5.localEulerAngles = var_222_5.localEulerAngles
			end

			local var_222_7 = arg_219_1.actors_["1019ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1019ui_story = var_222_7.localPosition
			end

			local var_222_8 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_8 then
				var_222_7.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_219_1.time_ - 0) / var_222_8)
				var_222_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_7.position).x, (manager.ui.mainCamera.transform.position - var_222_7.position).y, (manager.ui.mainCamera.transform.position - var_222_7.position).z)
				var_222_7.localEulerAngles.z = 0
				var_222_7.localEulerAngles.x = 0
				var_222_7.localEulerAngles = var_222_7.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_8 and arg_219_1.time_ < 0 + var_222_8 + arg_222_0 then
				var_222_7.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_222_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_7.position).x, (manager.ui.mainCamera.transform.position - var_222_7.position).y, (manager.ui.mainCamera.transform.position - var_222_7.position).z)
				var_222_7.localEulerAngles.z = 0
				var_222_7.localEulerAngles.x = 0
				var_222_7.localEulerAngles = var_222_7.localEulerAngles
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_222_9 = 0
			local var_222_10 = 0.525

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_11 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(318161054).content)

				arg_219_1.text_.text = var_222_11

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 21 <= 0 and var_222_10 or var_222_10 * (utf8.len(var_222_11) / 21)

				if (21 <= 0 and var_222_10 or var_222_10 * (utf8.len(var_222_11) / 21)) > 0 and var_222_10 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_9 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_9
					end
				end

				arg_219_1.text_.text = var_222_11
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_10, arg_219_1.talkMaxDuration)

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_9) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_9 + var_222_14 and arg_219_1.time_ < var_222_9 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play318161055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 318161055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play318161056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.925

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(318161055).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 37 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 37)

				if (37 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 37)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play318161056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 318161056
		arg_227_1.duration_ = 3.23

		local var_227_0 = {
			zh = 3.233,
			ja = 3.166
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
				arg_227_0:Play318161057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1033ui_story"]) and arg_227_1.var_.characterEffect1033ui_story == nil then
				arg_227_1.var_.characterEffect1033ui_story = arg_227_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1033ui_story"]) then
				if arg_227_1.var_.characterEffect1033ui_story and not isNil(arg_227_1.actors_["1033ui_story"]) then
					arg_227_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1033ui_story"]) and arg_227_1.var_.characterEffect1033ui_story then
				arg_227_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_2 = 0
			local var_230_3 = 0.425

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
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

				local var_230_4 = arg_227_1:GetWordFromCfg(318161056)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 17 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 17)

				if (17 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 17)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161056", "story_v_out_318161.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161056", "story_v_out_318161.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_318161", "318161056", "story_v_out_318161.awb")

						arg_227_1:RecordAudio("318161056", var_230_9)
						arg_227_1:RecordAudio("318161056", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_318161", "318161056", "story_v_out_318161.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_318161", "318161056", "story_v_out_318161.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play318161057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 318161057
		arg_231_1.duration_ = 2.37

		local var_231_0 = {
			zh = 2.1,
			ja = 2.366
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
				arg_231_0:Play318161058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.275

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
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

				local var_234_1 = arg_231_1:GetWordFromCfg(318161057)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 11 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 11)

				if (11 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 11)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161057", "story_v_out_318161.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_318161", "318161057", "story_v_out_318161.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_318161", "318161057", "story_v_out_318161.awb")

						arg_231_1:RecordAudio("318161057", var_234_6)
						arg_231_1:RecordAudio("318161057", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_318161", "318161057", "story_v_out_318161.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_318161", "318161057", "story_v_out_318161.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play318161058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 318161058
		arg_235_1.duration_ = 9

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play318161059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if arg_235_1.bgs_.K16f == nil then
				local var_238_0 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K16f")
				var_238_0.name = "K16f"
				var_238_0.transform.parent = arg_235_1.stage_.transform
				var_238_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_.K16f = var_238_0
			end

			if 2 < arg_235_1.time_ and arg_235_1.time_ <= 2 + arg_238_0 then
				local var_238_1 = arg_235_1.bgs_.K16f

				arg_235_1.bgs_.K16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_238_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_2 = var_238_1:GetComponent("SpriteRenderer")

				if var_238_2 and var_238_2.sprite then
					local var_238_3 = 2 * (var_238_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_238_1.transform.localScale = Vector3.New(var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "K16f" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_4 = 0

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_5 = 2

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_5 then
				local var_238_6 = Color.New(0, 0, 0)

				var_238_6.a = Mathf.Lerp(0, 1, (arg_235_1.time_ - var_238_4) / var_238_5)
				arg_235_1.mask_.color = var_238_6
			end

			if arg_235_1.time_ >= var_238_4 + var_238_5 and arg_235_1.time_ < var_238_4 + var_238_5 + arg_238_0 then
				local var_238_7 = Color.New(0, 0, 0)

				var_238_7.a = 1
				arg_235_1.mask_.color = var_238_7
			end

			local var_238_8 = 2

			if 2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_9 = 2

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_9 then
				local var_238_10 = Color.New(0, 0, 0)

				var_238_10.a = Mathf.Lerp(1, 0, (arg_235_1.time_ - var_238_8) / var_238_9)
				arg_235_1.mask_.color = var_238_10
			end

			if arg_235_1.time_ >= var_238_8 + var_238_9 and arg_235_1.time_ < var_238_8 + var_238_9 + arg_238_0 then
				local var_238_11 = Color.New(0, 0, 0)

				arg_235_1.mask_.enabled = false
				var_238_11.a = 0
				arg_235_1.mask_.color = var_238_11
			end

			local var_238_12 = arg_235_1.actors_["1033ui_story"].transform

			if 1.96599999815226 < arg_235_1.time_ and arg_235_1.time_ <= 1.96599999815226 + arg_238_0 then
				arg_235_1.var_.moveOldPos1033ui_story = var_238_12.localPosition
			end

			local var_238_13 = 0.001

			if 1.96599999815226 <= arg_235_1.time_ and arg_235_1.time_ < 1.96599999815226 + var_238_13 then
				var_238_12.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 1.96599999815226) / var_238_13)
				var_238_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_12.position).x, (manager.ui.mainCamera.transform.position - var_238_12.position).y, (manager.ui.mainCamera.transform.position - var_238_12.position).z)
				var_238_12.localEulerAngles.z = 0
				var_238_12.localEulerAngles.x = 0
				var_238_12.localEulerAngles = var_238_12.localEulerAngles
			end

			if arg_235_1.time_ >= 1.96599999815226 + var_238_13 and arg_235_1.time_ < 1.96599999815226 + var_238_13 + arg_238_0 then
				var_238_12.localPosition = Vector3.New(0, 100, 0)
				var_238_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_12.position).x, (manager.ui.mainCamera.transform.position - var_238_12.position).y, (manager.ui.mainCamera.transform.position - var_238_12.position).z)
				var_238_12.localEulerAngles.z = 0
				var_238_12.localEulerAngles.x = 0
				var_238_12.localEulerAngles = var_238_12.localEulerAngles
			end

			local var_238_14 = arg_235_1.actors_["1033ui_story"]

			if 1.96599999815226 < arg_235_1.time_ and arg_235_1.time_ <= 1.96599999815226 + arg_238_0 and not isNil(var_238_14) and arg_235_1.var_.characterEffect1033ui_story == nil then
				arg_235_1.var_.characterEffect1033ui_story = var_238_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_15 = 0.034000001847744

			if 1.96599999815226 <= arg_235_1.time_ and arg_235_1.time_ < 1.96599999815226 + var_238_15 and not isNil(var_238_14) then
				if arg_235_1.var_.characterEffect1033ui_story and not isNil(var_238_14) then
					arg_235_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 1.96599999815226) / var_238_15)
				end
			end

			if arg_235_1.time_ >= 1.96599999815226 + var_238_15 and arg_235_1.time_ < 1.96599999815226 + var_238_15 + arg_238_0 and not isNil(var_238_14) and arg_235_1.var_.characterEffect1033ui_story then
				arg_235_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_238_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_235_1.bgmTxt_.text ~= var_238_18 and arg_235_1.bgmTxt_.text ~= "" then
						if arg_235_1.bgmTxt2_.text ~= "" then
							arg_235_1.bgmTxt_.text = arg_235_1.bgmTxt2_.text
						end

						arg_235_1.bgmTxt2_.text = var_238_18

						arg_235_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_235_1.bgmTxt_.text = var_238_18
						arg_235_1.bgmTxt2_.text = var_238_18
					end

					if arg_235_1.bgmTimer then
						arg_235_1.bgmTimer:Stop()

						arg_235_1.bgmTimer = nil
					end

					if arg_235_1.settingData.show_music_name == 1 then
						arg_235_1.musicController:SetSelectedState("show")
						arg_235_1.musicAnimator_:Play("open", 0, 0)

						if arg_235_1.settingData.music_time ~= 0 then
							arg_235_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_235_1.settingData.music_time), function()
								if arg_235_1 == nil or isNil(arg_235_1.bgmTxt_) then
									return
								end

								arg_235_1.musicController:SetSelectedState("hide")
								arg_235_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.8 < arg_235_1.time_ and arg_235_1.time_ <= 0.8 + arg_238_0 then
				arg_235_1:AudioAction("play", "music", "bgm_activity_2_10_story_sasanami_photonrail", "bgm_activity_2_10_story_sasanami_photonrail", "bgm_activity_2_10_story_sasanami_photonrail.awb")

				local var_238_21 = manager.audio:GetAudioName("bgm_activity_2_10_story_sasanami_photonrail", "bgm_activity_2_10_story_sasanami_photonrail")

				if "" ~= "" then
					if arg_235_1.bgmTxt_.text ~= var_238_21 and arg_235_1.bgmTxt_.text ~= "" then
						if arg_235_1.bgmTxt2_.text ~= "" then
							arg_235_1.bgmTxt_.text = arg_235_1.bgmTxt2_.text
						end

						arg_235_1.bgmTxt2_.text = var_238_21

						arg_235_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_235_1.bgmTxt_.text = var_238_21
						arg_235_1.bgmTxt2_.text = var_238_21
					end

					if arg_235_1.bgmTimer then
						arg_235_1.bgmTimer:Stop()

						arg_235_1.bgmTimer = nil
					end

					if arg_235_1.settingData.show_music_name == 1 then
						arg_235_1.musicController:SetSelectedState("show")
						arg_235_1.musicAnimator_:Play("open", 0, 0)

						if arg_235_1.settingData.music_time ~= 0 then
							arg_235_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_235_1.settingData.music_time), function()
								if arg_235_1 == nil or isNil(arg_235_1.bgmTxt_) then
									return
								end

								arg_235_1.musicController:SetSelectedState("hide")
								arg_235_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_238_22 = arg_235_1.actors_["1019ui_story"].transform

			if 1.96599999815226 < arg_235_1.time_ and arg_235_1.time_ <= 1.96599999815226 + arg_238_0 then
				arg_235_1.var_.moveOldPos1019ui_story = var_238_22.localPosition
			end

			local var_238_23 = 0.001

			if 1.96599999815226 <= arg_235_1.time_ and arg_235_1.time_ < 1.96599999815226 + var_238_23 then
				var_238_22.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 1.96599999815226) / var_238_23)
				var_238_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_22.position).x, (manager.ui.mainCamera.transform.position - var_238_22.position).y, (manager.ui.mainCamera.transform.position - var_238_22.position).z)
				var_238_22.localEulerAngles.z = 0
				var_238_22.localEulerAngles.x = 0
				var_238_22.localEulerAngles = var_238_22.localEulerAngles
			end

			if arg_235_1.time_ >= 1.96599999815226 + var_238_23 and arg_235_1.time_ < 1.96599999815226 + var_238_23 + arg_238_0 then
				var_238_22.localPosition = Vector3.New(0, 100, 0)
				var_238_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_22.position).x, (manager.ui.mainCamera.transform.position - var_238_22.position).y, (manager.ui.mainCamera.transform.position - var_238_22.position).z)
				var_238_22.localEulerAngles.z = 0
				var_238_22.localEulerAngles.x = 0
				var_238_22.localEulerAngles = var_238_22.localEulerAngles
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_24 = 4
			local var_238_25 = 0.625

			if 4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_24 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_26 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_26:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_235_1.dialogCg_.alpha = arg_241_0
				end))
				var_238_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_27 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(318161058).content)

				arg_235_1.text_.text = var_238_27

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_29 = 25 <= 0 and var_238_25 or var_238_25 * (utf8.len(var_238_27) / 25)

				if (25 <= 0 and var_238_25 or var_238_25 * (utf8.len(var_238_27) / 25)) > 0 and var_238_25 < var_238_29 then
					arg_235_1.talkMaxDuration = var_238_29
					var_238_24 = var_238_24 + 0.3

					if var_238_29 + var_238_24 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_29 + var_238_24
					end
				end

				arg_235_1.text_.text = var_238_27
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_30 = var_238_24 + 0.3
			local var_238_31 = math.max(var_238_25, arg_235_1.talkMaxDuration)

			if var_238_24 + 0.3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_30 + var_238_31 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_30) / var_238_31

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_30 + var_238_31 and arg_235_1.time_ < var_238_30 + var_238_31 + arg_238_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play318161059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 318161059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play318161060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 1.375

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(318161059).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 55 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 55)

				if (55 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 55)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play318161060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 318161060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play318161061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.15

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(318161060).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 46 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 46)

				if (46 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 46)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play318161061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 318161061
		arg_251_1.duration_ = 7.2

		local var_251_0 = {
			zh = 3.433,
			ja = 7.2
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play318161062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if arg_251_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_254_0 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_251_1.stage_.transform)

				var_254_0.name = "1049ui_story"
				var_254_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.actors_["1049ui_story"] = var_254_0

				local var_254_1 = var_254_0:GetComponentInChildren(typeof(CharacterEffect))

				var_254_1.enabled = true

				local var_254_2 = GameObjectTools.GetOrAddComponent(var_254_0, typeof(DynamicBoneHelper))

				if var_254_2 then
					var_254_2:EnableDynamicBone(false)
				end

				arg_251_1:ShowWeapon(var_254_1.transform, false)

				arg_251_1.var_["1049ui_story" .. "Animator"] = var_254_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_251_1.var_["1049ui_story" .. "Animator"].applyRootMotion = true
				arg_251_1.var_["1049ui_story" .. "LipSync"] = var_254_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_254_3 = arg_251_1.actors_["1049ui_story"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1049ui_story = var_254_3.localPosition
			end

			local var_254_4 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				var_254_3.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_251_1.time_ - 0) / var_254_4)
				var_254_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_3.position).x, (manager.ui.mainCamera.transform.position - var_254_3.position).y, (manager.ui.mainCamera.transform.position - var_254_3.position).z)
				var_254_3.localEulerAngles.z = 0
				var_254_3.localEulerAngles.x = 0
				var_254_3.localEulerAngles = var_254_3.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				var_254_3.localPosition = Vector3.New(0, -1.2, -6)
				var_254_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_3.position).x, (manager.ui.mainCamera.transform.position - var_254_3.position).y, (manager.ui.mainCamera.transform.position - var_254_3.position).z)
				var_254_3.localEulerAngles.z = 0
				var_254_3.localEulerAngles.x = 0
				var_254_3.localEulerAngles = var_254_3.localEulerAngles
			end

			local var_254_5 = arg_251_1.actors_["1049ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_5) and arg_251_1.var_.characterEffect1049ui_story == nil then
				arg_251_1.var_.characterEffect1049ui_story = var_254_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_6 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_6 and not isNil(var_254_5) then
				if arg_251_1.var_.characterEffect1049ui_story and not isNil(var_254_5) then
					arg_251_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_6 and arg_251_1.time_ < 0 + var_254_6 + arg_254_0 and not isNil(var_254_5) and arg_251_1.var_.characterEffect1049ui_story then
				arg_251_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_254_8 = 0
			local var_254_9 = 0.425

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_10 = arg_251_1:GetWordFromCfg(318161061)
				local var_254_11 = arg_251_1:FormatText(var_254_10.content)

				arg_251_1.text_.text = var_254_11

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 17 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 17)

				if (17 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 17)) > 0 and var_254_9 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_11
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161061", "story_v_out_318161.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_out_318161", "318161061", "story_v_out_318161.awb") / 1000

					if var_254_14 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_8
					end

					if var_254_10.prefab_name ~= "" and arg_251_1.actors_[var_254_10.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_10.prefab_name].transform, "story_v_out_318161", "318161061", "story_v_out_318161.awb")

						arg_251_1:RecordAudio("318161061", var_254_15)
						arg_251_1:RecordAudio("318161061", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_318161", "318161061", "story_v_out_318161.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_318161", "318161061", "story_v_out_318161.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_16 and arg_251_1.time_ < var_254_8 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play318161062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 318161062
		arg_255_1.duration_ = 1

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"

			SetActive(arg_255_1.choicesGo_, true)

			for iter_256_0, iter_256_1 in ipairs(arg_255_1.choices_) do
				SetActive(iter_256_1.go, iter_256_0 <= 2)
			end

			arg_255_1.choices_[1].txt.text = arg_255_1:FormatText(StoryChoiceCfg[674].name)
			arg_255_1.choices_[2].txt.text = arg_255_1:FormatText(StoryChoiceCfg[675].name)
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play318161063(arg_255_1)
			end

			if arg_257_0 == 2 then
				arg_255_0:Play318161064(arg_255_1)
			end

			arg_255_1:RecordChoiceLog(318161062, 674, 675)
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1049ui_story"]) and arg_255_1.var_.characterEffect1049ui_story == nil then
				arg_255_1.var_.characterEffect1049ui_story = arg_255_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1049ui_story"]) then
				if arg_255_1.var_.characterEffect1049ui_story and not isNil(arg_255_1.actors_["1049ui_story"]) then
					arg_255_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1049ui_story"]) and arg_255_1.var_.characterEffect1049ui_story then
				arg_255_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.allBtn_.enabled = false
			end

			if arg_255_1.time_ >= var_258_1 + 0.5 and arg_255_1.time_ < var_258_1 + 0.5 + arg_258_0 then
				arg_255_1.allBtn_.enabled = true
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play318161063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 318161063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play318161065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.375

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(318161063).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 16 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 16)

				if (16 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 16)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play318161065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 318161065
		arg_263_1.duration_ = 5.47

		local var_263_0 = {
			zh = 2.5,
			ja = 5.466
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play318161066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1049ui_story"]) and arg_263_1.var_.characterEffect1049ui_story == nil then
				arg_263_1.var_.characterEffect1049ui_story = arg_263_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1049ui_story"]) then
				if arg_263_1.var_.characterEffect1049ui_story and not isNil(arg_263_1.actors_["1049ui_story"]) then
					arg_263_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1049ui_story"]) and arg_263_1.var_.characterEffect1049ui_story then
				arg_263_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_266_2 = 0
			local var_266_3 = 0.225

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:GetWordFromCfg(318161065)
				local var_266_5 = arg_263_1:FormatText(var_266_4.content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 9 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 9)

				if (9 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 9)) > 0 and var_266_3 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161065", "story_v_out_318161.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161065", "story_v_out_318161.awb") / 1000

					if var_266_8 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_2
					end

					if var_266_4.prefab_name ~= "" and arg_263_1.actors_[var_266_4.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_4.prefab_name].transform, "story_v_out_318161", "318161065", "story_v_out_318161.awb")

						arg_263_1:RecordAudio("318161065", var_266_9)
						arg_263_1:RecordAudio("318161065", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_318161", "318161065", "story_v_out_318161.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_318161", "318161065", "story_v_out_318161.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_10 and arg_263_1.time_ < var_266_2 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play318161066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 318161066
		arg_267_1.duration_ = 4.6

		local var_267_0 = {
			zh = 3,
			ja = 4.6
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play318161067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if arg_267_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_270_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_267_1.stage_.transform)

				var_270_0.name = "1015ui_story"
				var_270_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.actors_["1015ui_story"] = var_270_0

				local var_270_1 = var_270_0:GetComponentInChildren(typeof(CharacterEffect))

				var_270_1.enabled = true

				local var_270_2 = GameObjectTools.GetOrAddComponent(var_270_0, typeof(DynamicBoneHelper))

				if var_270_2 then
					var_270_2:EnableDynamicBone(false)
				end

				arg_267_1:ShowWeapon(var_270_1.transform, false)

				arg_267_1.var_["1015ui_story" .. "Animator"] = var_270_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_267_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_267_1.var_["1015ui_story" .. "LipSync"] = var_270_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_270_3 = arg_267_1.actors_["1015ui_story"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1015ui_story = var_270_3.localPosition
			end

			local var_270_4 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				var_270_3.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_267_1.time_ - 0) / var_270_4)
				var_270_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_3.position).x, (manager.ui.mainCamera.transform.position - var_270_3.position).y, (manager.ui.mainCamera.transform.position - var_270_3.position).z)
				var_270_3.localEulerAngles.z = 0
				var_270_3.localEulerAngles.x = 0
				var_270_3.localEulerAngles = var_270_3.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				var_270_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_270_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_3.position).x, (manager.ui.mainCamera.transform.position - var_270_3.position).y, (manager.ui.mainCamera.transform.position - var_270_3.position).z)
				var_270_3.localEulerAngles.z = 0
				var_270_3.localEulerAngles.x = 0
				var_270_3.localEulerAngles = var_270_3.localEulerAngles
			end

			local var_270_5 = arg_267_1.actors_["1015ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_5) and arg_267_1.var_.characterEffect1015ui_story == nil then
				arg_267_1.var_.characterEffect1015ui_story = var_270_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_6 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_6 and not isNil(var_270_5) then
				if arg_267_1.var_.characterEffect1015ui_story and not isNil(var_270_5) then
					arg_267_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_6 and arg_267_1.time_ < 0 + var_270_6 + arg_270_0 and not isNil(var_270_5) and arg_267_1.var_.characterEffect1015ui_story then
				arg_267_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_270_8 = arg_267_1.actors_["1049ui_story"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1049ui_story = var_270_8.localPosition
			end

			local var_270_9 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_9 then
				var_270_8.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 0) / var_270_9)
				var_270_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_8.position).x, (manager.ui.mainCamera.transform.position - var_270_8.position).y, (manager.ui.mainCamera.transform.position - var_270_8.position).z)
				var_270_8.localEulerAngles.z = 0
				var_270_8.localEulerAngles.x = 0
				var_270_8.localEulerAngles = var_270_8.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_9 and arg_267_1.time_ < 0 + var_270_9 + arg_270_0 then
				var_270_8.localPosition = Vector3.New(0, 100, 0)
				var_270_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_8.position).x, (manager.ui.mainCamera.transform.position - var_270_8.position).y, (manager.ui.mainCamera.transform.position - var_270_8.position).z)
				var_270_8.localEulerAngles.z = 0
				var_270_8.localEulerAngles.x = 0
				var_270_8.localEulerAngles = var_270_8.localEulerAngles
			end

			local var_270_10 = arg_267_1.actors_["1049ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_10) and arg_267_1.var_.characterEffect1049ui_story == nil then
				arg_267_1.var_.characterEffect1049ui_story = var_270_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_11 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_11 and not isNil(var_270_10) then
				if arg_267_1.var_.characterEffect1049ui_story and not isNil(var_270_10) then
					arg_267_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_11)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_11 and arg_267_1.time_ < 0 + var_270_11 + arg_270_0 and not isNil(var_270_10) and arg_267_1.var_.characterEffect1049ui_story then
				arg_267_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_270_12 = 0
			local var_270_13 = 0.6

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_12 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_14 = arg_267_1:GetWordFromCfg(318161066)
				local var_270_15 = arg_267_1:FormatText(var_270_14.content)

				arg_267_1.text_.text = var_270_15

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_17 = 24 <= 0 and var_270_13 or var_270_13 * (utf8.len(var_270_15) / 24)

				if (24 <= 0 and var_270_13 or var_270_13 * (utf8.len(var_270_15) / 24)) > 0 and var_270_13 < var_270_17 then
					arg_267_1.talkMaxDuration = var_270_17

					if var_270_17 + var_270_12 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_17 + var_270_12
					end
				end

				arg_267_1.text_.text = var_270_15
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161066", "story_v_out_318161.awb") ~= 0 then
					local var_270_18 = manager.audio:GetVoiceLength("story_v_out_318161", "318161066", "story_v_out_318161.awb") / 1000

					if var_270_18 + var_270_12 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_18 + var_270_12
					end

					if var_270_14.prefab_name ~= "" and arg_267_1.actors_[var_270_14.prefab_name] ~= nil then
						local var_270_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_14.prefab_name].transform, "story_v_out_318161", "318161066", "story_v_out_318161.awb")

						arg_267_1:RecordAudio("318161066", var_270_19)
						arg_267_1:RecordAudio("318161066", var_270_19)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_318161", "318161066", "story_v_out_318161.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_318161", "318161066", "story_v_out_318161.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_20 = math.max(var_270_13, arg_267_1.talkMaxDuration)

			if var_270_12 <= arg_267_1.time_ and arg_267_1.time_ < var_270_12 + var_270_20 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_12) / var_270_20

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_12 + var_270_20 and arg_267_1.time_ < var_270_12 + var_270_20 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play318161067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 318161067
		arg_271_1.duration_ = 3.53

		local var_271_0 = {
			zh = 2.566,
			ja = 3.533
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play318161068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if arg_271_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_274_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_271_1.stage_.transform)

				var_274_0.name = "10066ui_story"
				var_274_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.actors_["10066ui_story"] = var_274_0

				local var_274_1 = var_274_0:GetComponentInChildren(typeof(CharacterEffect))

				var_274_1.enabled = true

				local var_274_2 = GameObjectTools.GetOrAddComponent(var_274_0, typeof(DynamicBoneHelper))

				if var_274_2 then
					var_274_2:EnableDynamicBone(false)
				end

				arg_271_1:ShowWeapon(var_274_1.transform, false)

				arg_271_1.var_["10066ui_story" .. "Animator"] = var_274_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_271_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_271_1.var_["10066ui_story" .. "LipSync"] = var_274_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_274_3 = arg_271_1.actors_["10066ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10066ui_story = var_274_3.localPosition
			end

			local var_274_4 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				var_274_3.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_271_1.time_ - 0) / var_274_4)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				var_274_3.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			local var_274_5 = arg_271_1.actors_["10066ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect10066ui_story == nil then
				arg_271_1.var_.characterEffect10066ui_story = var_274_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_6 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_6 and not isNil(var_274_5) then
				if arg_271_1.var_.characterEffect10066ui_story and not isNil(var_274_5) then
					arg_271_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_6 and arg_271_1.time_ < 0 + var_274_6 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect10066ui_story then
				arg_271_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_274_8 = arg_271_1.actors_["1015ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1015ui_story = var_274_8.localPosition
			end

			local var_274_9 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_9 then
				var_274_8.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_271_1.time_ - 0) / var_274_9)
				var_274_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_8.position).x, (manager.ui.mainCamera.transform.position - var_274_8.position).y, (manager.ui.mainCamera.transform.position - var_274_8.position).z)
				var_274_8.localEulerAngles.z = 0
				var_274_8.localEulerAngles.x = 0
				var_274_8.localEulerAngles = var_274_8.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_9 and arg_271_1.time_ < 0 + var_274_9 + arg_274_0 then
				var_274_8.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				var_274_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_8.position).x, (manager.ui.mainCamera.transform.position - var_274_8.position).y, (manager.ui.mainCamera.transform.position - var_274_8.position).z)
				var_274_8.localEulerAngles.z = 0
				var_274_8.localEulerAngles.x = 0
				var_274_8.localEulerAngles = var_274_8.localEulerAngles
			end

			local var_274_10 = arg_271_1.actors_["1015ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_10) and arg_271_1.var_.characterEffect1015ui_story == nil then
				arg_271_1.var_.characterEffect1015ui_story = var_274_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_11 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_11 and not isNil(var_274_10) then
				if arg_271_1.var_.characterEffect1015ui_story and not isNil(var_274_10) then
					arg_271_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_11)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_11 and arg_271_1.time_ < 0 + var_274_11 + arg_274_0 and not isNil(var_274_10) and arg_271_1.var_.characterEffect1015ui_story then
				arg_271_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_274_12 = 0
			local var_274_13 = 0.125

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_14 = arg_271_1:GetWordFromCfg(318161067)
				local var_274_15 = arg_271_1:FormatText(var_274_14.content)

				arg_271_1.text_.text = var_274_15

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_17 = 5 <= 0 and var_274_13 or var_274_13 * (utf8.len(var_274_15) / 5)

				if (5 <= 0 and var_274_13 or var_274_13 * (utf8.len(var_274_15) / 5)) > 0 and var_274_13 < var_274_17 then
					arg_271_1.talkMaxDuration = var_274_17

					if var_274_17 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_17 + var_274_12
					end
				end

				arg_271_1.text_.text = var_274_15
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161067", "story_v_out_318161.awb") ~= 0 then
					local var_274_18 = manager.audio:GetVoiceLength("story_v_out_318161", "318161067", "story_v_out_318161.awb") / 1000

					if var_274_18 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_18 + var_274_12
					end

					if var_274_14.prefab_name ~= "" and arg_271_1.actors_[var_274_14.prefab_name] ~= nil then
						local var_274_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_14.prefab_name].transform, "story_v_out_318161", "318161067", "story_v_out_318161.awb")

						arg_271_1:RecordAudio("318161067", var_274_19)
						arg_271_1:RecordAudio("318161067", var_274_19)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_318161", "318161067", "story_v_out_318161.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_318161", "318161067", "story_v_out_318161.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_20 = math.max(var_274_13, arg_271_1.talkMaxDuration)

			if var_274_12 <= arg_271_1.time_ and arg_271_1.time_ < var_274_12 + var_274_20 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_12) / var_274_20

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_12 + var_274_20 and arg_271_1.time_ < var_274_12 + var_274_20 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play318161068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 318161068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play318161069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["10066ui_story"]) and arg_275_1.var_.characterEffect10066ui_story == nil then
				arg_275_1.var_.characterEffect10066ui_story = arg_275_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["10066ui_story"]) then
				if arg_275_1.var_.characterEffect10066ui_story and not isNil(arg_275_1.actors_["10066ui_story"]) then
					arg_275_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["10066ui_story"]) and arg_275_1.var_.characterEffect10066ui_story then
				arg_275_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.725

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(318161068).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 29 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 29)

				if (29 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 29)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play318161069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 318161069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play318161070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 1.625

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(318161069).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 65 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 65)

				if (65 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 65)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play318161070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 318161070
		arg_283_1.duration_ = 3.67

		local var_283_0 = {
			zh = 3.5,
			ja = 3.666
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play318161071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1015ui_story"]) and arg_283_1.var_.characterEffect1015ui_story == nil then
				arg_283_1.var_.characterEffect1015ui_story = arg_283_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1015ui_story"]) then
				if arg_283_1.var_.characterEffect1015ui_story and not isNil(arg_283_1.actors_["1015ui_story"]) then
					arg_283_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1015ui_story"]) and arg_283_1.var_.characterEffect1015ui_story then
				arg_283_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015actionlink/1015action452")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_2 = 0
			local var_286_3 = 0.475

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:GetWordFromCfg(318161070)
				local var_286_5 = arg_283_1:FormatText(var_286_4.content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_7 = 19 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 19)

				if (19 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 19)) > 0 and var_286_3 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161070", "story_v_out_318161.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_318161", "318161070", "story_v_out_318161.awb") / 1000

					if var_286_8 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_2
					end

					if var_286_4.prefab_name ~= "" and arg_283_1.actors_[var_286_4.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_4.prefab_name].transform, "story_v_out_318161", "318161070", "story_v_out_318161.awb")

						arg_283_1:RecordAudio("318161070", var_286_9)
						arg_283_1:RecordAudio("318161070", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_318161", "318161070", "story_v_out_318161.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_318161", "318161070", "story_v_out_318161.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_10 and arg_283_1.time_ < var_286_2 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play318161071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 318161071
		arg_287_1.duration_ = 5.6

		local var_287_0 = {
			zh = 5.3,
			ja = 5.6
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play318161072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["10066ui_story"]) and arg_287_1.var_.characterEffect10066ui_story == nil then
				arg_287_1.var_.characterEffect10066ui_story = arg_287_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["10066ui_story"]) then
				if arg_287_1.var_.characterEffect10066ui_story and not isNil(arg_287_1.actors_["10066ui_story"]) then
					arg_287_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["10066ui_story"]) and arg_287_1.var_.characterEffect10066ui_story then
				arg_287_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_290_2 = arg_287_1.actors_["1015ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.characterEffect1015ui_story == nil then
				arg_287_1.var_.characterEffect1015ui_story = var_290_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_3 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_3 and not isNil(var_290_2) then
				if arg_287_1.var_.characterEffect1015ui_story and not isNil(var_290_2) then
					arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_3)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_3 and arg_287_1.time_ < 0 + var_290_3 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.characterEffect1015ui_story then
				arg_287_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action443")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_290_4 = 0
			local var_290_5 = 0.625

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(318161071)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 25 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 25)

				if (25 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 25)) > 0 and var_290_5 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161071", "story_v_out_318161.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161071", "story_v_out_318161.awb") / 1000

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end

					if var_290_6.prefab_name ~= "" and arg_287_1.actors_[var_290_6.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_6.prefab_name].transform, "story_v_out_318161", "318161071", "story_v_out_318161.awb")

						arg_287_1:RecordAudio("318161071", var_290_11)
						arg_287_1:RecordAudio("318161071", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_318161", "318161071", "story_v_out_318161.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_318161", "318161071", "story_v_out_318161.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_12 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_12 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_12

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_12 and arg_287_1.time_ < var_290_4 + var_290_12 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play318161072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 318161072
		arg_291_1.duration_ = 3.4

		local var_291_0 = {
			zh = 3.4,
			ja = 3.033
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play318161073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1015ui_story"]) and arg_291_1.var_.characterEffect1015ui_story == nil then
				arg_291_1.var_.characterEffect1015ui_story = arg_291_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1015ui_story"]) then
				if arg_291_1.var_.characterEffect1015ui_story and not isNil(arg_291_1.actors_["1015ui_story"]) then
					arg_291_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1015ui_story"]) and arg_291_1.var_.characterEffect1015ui_story then
				arg_291_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_294_2 = arg_291_1.actors_["10066ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.characterEffect10066ui_story == nil then
				arg_291_1.var_.characterEffect10066ui_story = var_294_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_3 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 and not isNil(var_294_2) then
				if arg_291_1.var_.characterEffect10066ui_story and not isNil(var_294_2) then
					arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_3)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.characterEffect10066ui_story then
				arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			local var_294_4 = 0
			local var_294_5 = 0.45

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_6 = arg_291_1:GetWordFromCfg(318161072)
				local var_294_7 = arg_291_1:FormatText(var_294_6.content)

				arg_291_1.text_.text = var_294_7

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_9 = 18 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 18)

				if (18 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 18)) > 0 and var_294_5 < var_294_9 then
					arg_291_1.talkMaxDuration = var_294_9

					if var_294_9 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_9 + var_294_4
					end
				end

				arg_291_1.text_.text = var_294_7
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161072", "story_v_out_318161.awb") ~= 0 then
					local var_294_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161072", "story_v_out_318161.awb") / 1000

					if var_294_10 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_4
					end

					if var_294_6.prefab_name ~= "" and arg_291_1.actors_[var_294_6.prefab_name] ~= nil then
						local var_294_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_6.prefab_name].transform, "story_v_out_318161", "318161072", "story_v_out_318161.awb")

						arg_291_1:RecordAudio("318161072", var_294_11)
						arg_291_1:RecordAudio("318161072", var_294_11)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_318161", "318161072", "story_v_out_318161.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_318161", "318161072", "story_v_out_318161.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_12 = math.max(var_294_5, arg_291_1.talkMaxDuration)

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_12 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_4) / var_294_12

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_4 + var_294_12 and arg_291_1.time_ < var_294_4 + var_294_12 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play318161073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 318161073
		arg_295_1.duration_ = 8.7

		local var_295_0 = {
			zh = 7.666,
			ja = 8.7
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play318161074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.825

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:GetWordFromCfg(318161073)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 33 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 33)

				if (33 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 33)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161073", "story_v_out_318161.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_318161", "318161073", "story_v_out_318161.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_318161", "318161073", "story_v_out_318161.awb")

						arg_295_1:RecordAudio("318161073", var_298_6)
						arg_295_1:RecordAudio("318161073", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_318161", "318161073", "story_v_out_318161.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_318161", "318161073", "story_v_out_318161.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play318161074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 318161074
		arg_299_1.duration_ = 5.53

		local var_299_0 = {
			zh = 2.8,
			ja = 5.533
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play318161075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["10066ui_story"]) and arg_299_1.var_.characterEffect10066ui_story == nil then
				arg_299_1.var_.characterEffect10066ui_story = arg_299_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["10066ui_story"]) then
				if arg_299_1.var_.characterEffect10066ui_story and not isNil(arg_299_1.actors_["10066ui_story"]) then
					arg_299_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["10066ui_story"]) and arg_299_1.var_.characterEffect10066ui_story then
				arg_299_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_302_2 = arg_299_1.actors_["1015ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.characterEffect1015ui_story == nil then
				arg_299_1.var_.characterEffect1015ui_story = var_302_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_3 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.characterEffect1015ui_story and not isNil(var_302_2) then
					arg_299_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_3)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.characterEffect1015ui_story then
				arg_299_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action434")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_302_4 = 0
			local var_302_5 = 0.175

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(318161074)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 7 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 7)

				if (7 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 7)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318161", "318161074", "story_v_out_318161.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_out_318161", "318161074", "story_v_out_318161.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_out_318161", "318161074", "story_v_out_318161.awb")

						arg_299_1:RecordAudio("318161074", var_302_11)
						arg_299_1:RecordAudio("318161074", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_318161", "318161074", "story_v_out_318161.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_318161", "318161074", "story_v_out_318161.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_12 and arg_299_1.time_ < var_302_4 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play318161075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 318161075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
			arg_303_1.auto_ = false
		end

		function arg_303_1.playNext_(arg_305_0)
			arg_303_1.onStoryFinished_()
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["10066ui_story"]) and arg_303_1.var_.characterEffect10066ui_story == nil then
				arg_303_1.var_.characterEffect10066ui_story = arg_303_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["10066ui_story"]) then
				if arg_303_1.var_.characterEffect10066ui_story and not isNil(arg_303_1.actors_["10066ui_story"]) then
					arg_303_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_303_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["10066ui_story"]) and arg_303_1.var_.characterEffect10066ui_story then
				arg_303_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_303_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.225

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(318161075).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 9 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 9)

				if (9 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 9)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play318161064 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 318161064
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play318161065(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.45

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(318161064).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 18 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 18)

				if (18 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 18)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/K16f"
	},
	voices = {
		"story_v_out_318161.awb"
	}
}
